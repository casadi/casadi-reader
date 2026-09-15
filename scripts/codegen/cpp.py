from .base import Emitter, indent
import json


class Cpp(Emitter):
    quote = staticmethod(json.dumps)

    def literal(self, value):
        if isinstance(value, bool):
            return f"JsonValue::boolean({str(value).lower()})"
        if value is None:
            return "JsonValue()"
        if isinstance(value, str):
            return f"JsonValue({self.quote(value)})"
        return f"JsonValue(int64_t({value}))"

    def name(self, step):
        return (
            self.quote(step["name"])
            if step.get("name") is not None
            else self.string_operand(step["name_expression"])
        )

    def string_operand(self, operand):
        if isinstance(operand, str):
            return self.quote(operand)
        if operand[0] == "literal":
            return self.quote(str(operand[1]))
        if operand[0] == "concat":
            return f"(std::string({self.string_operand(operand[1])}) + {self.string_operand(operand[2])})"
        return f"({self.expr(operand)}).scalar"

    def expr(self, operand):
        if operand[0] in ("field", "parameter"):
            return f"scope.at({self.string_operand(operand[1])})"
        return super().expr(operand)

    def condition(self, operand):
        op, *args = operand
        if op == "literal":
            return str(bool(args[0])).lower()
        if op == "not":
            return f"(!({self.condition(args[0])}))"
        if op in ("and", "or"):
            return (
                f"({self.condition(args[0])} "
                + {"and": "&&", "or": "||"}[op]
                + f" {self.condition(args[1])})"
            )
        if op in ("equal", "not_equal"):
            a, b = args
            symbol = "==" if op == "equal" else "!="
            if b[0] == "literal" and isinstance(b[1], str):
                return f"({self.expr(a)}).scalar {symbol} {self.quote(b[1])}"
            return f"({self.expr(a)}).dump() {symbol} ({self.expr(b)}).dump()"
        return f"truth({self.expr(operand)})"

    def operator(self, op, args):
        a = args[0]
        if op == "length":
            return f"JsonValue(int64_t(({a}).a.size()))"
        if op == "not":
            return f"JsonValue::boolean(!truth({a}))"
        b = args[1]
        if op == "concat":
            return f"JsonValue(({a}).scalar + ({b}).scalar)"
        if op in ("equal", "not_equal"):
            return (
                f"JsonValue::boolean(({a}).dump() "
                + ("==" if op == "equal" else "!=")
                + f" ({b}).dump())"
            )
        return f"JsonValue::boolean(truth({a}) " + {"and": "&&", "or": "||"}[op] + f" truth({b}))"

    def invoke(self, name):
        return f"{name}()"

    def primitive(self, kind):
        q = self.quote(kind)
        if kind in ("int", "unsignedint", "casadi_int", "size_t", "double"):
            return f"number({q})"
        return {
            "char": "JsonValue(byte())",
            "bool": "boolvalue()",
            "std::string": "string()",
            "std::istream": "streamvalue()",
            "std::stringstream": "streamvalue()",
        }.get(kind, f"primitive({q})")

    def assign(self, name, value):
        return [f"const auto {name} = {value};"]

    def tag(self, value):
        return f"({value}).scalar"

    def failure(self, reason):
        return [f"fail({self.quote(reason)});"]

    def field(self, name, kind, retain):
        call = f"field(record, {name}, {self.quote(kind)}, [&]() {{ return {self.read(kind)}; }})"
        return [(f"scope[{name}] = " if retain else "") + call + ";"]

    def version(self, name, version):
        return [f"version(record, {name}, {version});"]

    def call_layout(self, name, params):
        return [
            f'record["layouts"].a.push_back({self.literal(name)});',
            *[f"scope[{self.quote(k)}] = {self.literal(v)};" for k, v in params.items()],
            f'{self.names["layouts",name]}(record, scope);',
        ]

    def branch(self, condition, yes, no):
        lines = [f"if ({condition}) {{", *indent(yes)]
        if no:
            lines += ["} else {", *indent(no)]
        return lines + ["}"]

    def select(self, tag, cases):
        lines = []
        for key, body in cases:
            lines += [
                ("if" if not lines else "} else if") + f" ({tag} == {self.quote(key)}) {{",
                *indent(body),
            ]
        return (
            lines + ["} else {", *indent(self.failure("Unknown serialization discriminator")), "}"]
            if lines
            else self.failure("Unknown serialization discriminator")
        )

    def repeat(self, count, body):
        n, i = self.fresh("count"), self.fresh("i")
        return [
            f"const auto {n} = this->count({count});",
            f"for (uint64_t {i} = 0; {i} < {n}; ++{i}) {{",
            *indent(body),
            "}",
        ]

    def function(self, name, body, layout=False):
        if layout:
            body = ["enter_layout();", *body, "--depth;"]
        signature = (
            f"void {name}(JsonValue& record, Scope& scope)" if layout else f"JsonValue {name}()"
        )
        return "\n".join([signature + " {", *indent(body), "}", ""])

    def object(self, kind, definition, body):
        return [
            f'return object({self.quote(kind)}, {self.quote(definition.get("decoration", ""))}, {str(definition.get("shared", False)).lower()}, &Reader::{body});'
        ]

    def container(self, definition):
        shape = definition["kind"]
        lines = [
            f'decoration(\'{ {"vector":"V","map":"D","pair":"p"}[shape] }\');',
            "JsonValue result = JsonValue::array();",
        ]
        if shape == "pair":
            return (
                lines
                + [
                    f"result.a.push_back({self.read(definition[slot])});"
                    for slot in ("first", "second")
                ]
                + ["return result;"]
            )
        lines += [
            'const auto n = count(number("casadi_int"));',
            "for (uint64_t i = 0; i < n; ++i) {",
        ]
        if shape == "vector":
            body = [f'result.a.push_back({self.read(definition["element"])});']
        else:
            body = [
                "JsonValue entry = JsonValue::array();",
                *[
                    f"entry.a.push_back({self.read(definition[slot])});"
                    for slot in ("key", "value")
                ],
                "result.a.push_back(std::move(entry));",
            ]
        lines += indent(body) + ["}"]
        if shape == "map":
            lines += [
                "JsonValue map = JsonValue::object();",
                'map["$map"] = std::move(result);',
                "return map;",
            ]
        else:
            lines += ["return result;"]
        return lines

    def generate(self):
        functions = self.functions()
        dispatch = ["JsonValue value(const std::string& type) {"]
        for (group, kind), name in self.names.items():
            if group != "layouts":
                dispatch += [f"    if (type == {self.quote(kind)}) return {name}();"]
        dispatch += ["    return primitive(type);", "}"]
        return (
            "// Generated from serialization_scheme.json; do not edit.\n"
            + "\n".join(functions + dispatch)
            + "\n"
        )

    def metadata_source(self):
        lines = [
            "/* Generated wire constants and file framing tags. */",
            "#include <stdint.h>",
            "#include <stddef.h>",
            f'static const int64_t serialization_magic = {self.data["wire"]["magic"]};',
            f'static const int64_t serialization_protocol = {self.data["wire"]["protocol"]};',
            "typedef struct { int tag; const char* type; const char* prefix; } FileType;",
            "static const FileType file_types[] = {",
        ]
        for tag, kind in self.reader["file_types"].items():
            prefix = self.reader["file_prefixes"].get(tag, "")
            lines.append(f"    {{{tag}, {self.quote(kind)}, {self.quote(prefix)}}},")
        lines += [
            "};",
            "static const FileType* file_type(int tag) {",
            "    for (size_t i = 0; i < sizeof(file_types) / sizeof(file_types[0]); ++i) {",
            "        if (file_types[i].tag == tag) return &file_types[i];",
            "    }",
            "    return NULL;",
            "}",
        ]
        return "\n".join(lines) + "\n"
