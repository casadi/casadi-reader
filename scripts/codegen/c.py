from .cpp import Cpp
from .base import Emitter, indent


class C(Cpp):
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
            return f"text(concat(d, {self.string_operand(operand[1])}, {self.string_operand(operand[2])}))"
        return f"text({self.expr(operand)})"

    def expr(self, operand):
        if operand[0] in ("field", "parameter"):
            return f"scope_value(d, scope, {self.string_operand(operand[1])})"
        return Emitter.expr(self, operand)

    def condition(self, operand):
        op, *args = operand
        if op == "literal":
            return str(int(bool(args[0])))
        if op == "not":
            return f"(!({self.condition(args[0])}))"
        if op in ("and", "or"):
            return (
                f"({self.condition(args[0])} "
                + {"and": "&&", "or": "||"}[op]
                + f" {self.condition(args[1])})"
            )
        if op in ("equal", "not_equal"):
            return (
                "!" if op == "not_equal" else ""
            ) + f"equal({self.expr(args[0])}, {self.expr(args[1])})"
        return f"truth({self.expr(operand)})"

    def literal(self, value):
        if isinstance(value, bool):
            return f"boolean(d, {int(value)})"
        if value is None:
            return "NULL"
        if isinstance(value, str):
            return f"str(d, {self.quote(value)})"
        return f"integer(d, {value})"

    def lookup(self, name):
        return f"scope_value(d, scope, {name})"

    def operator(self, op, args):
        a = args[0]
        if op == "length":
            return f"integer(d, (int64_t)({a})->count)"
        if op == "not":
            return f"boolean(d, !truth({a}))"
        b = args[1]
        if op == "concat":
            return f"concat(d, text({a}), text({b}))"
        if op in ("equal", "not_equal"):
            return f"boolean(d, " + ("!" if op == "not_equal" else "") + f"equal({a}, {b}))"
        return f"boolean(d, truth({a}) " + {"and": "&&", "or": "||"}[op] + f" truth({b}))"

    def invoke(self, name):
        return f"{name}(d)"

    def primitive(self, kind):
        q = self.quote(kind)
        if kind in ("int", "unsignedint", "casadi_int", "size_t", "double"):
            return f"number(d, {q})"
        return {
            "char": "integer(d, byte(d))",
            "bool": "boolvalue(d)",
            "std::string": "stringvalue(d)",
            "std::istream": "streamvalue(d)",
            "std::stringstream": "streamvalue(d)",
        }.get(kind, f"primitive(d, {q})")

    def assign(self, name, value):
        return [f"const char* {name} = {value};"]

    def tag(self, value):
        return f"text({value})"

    def failure(self, reason):
        return [f'fail(d, "%s", {self.quote(reason)});']

    def field(self, name, kind, retain):
        callback = self.names.get(("types", kind), self.names.get(("containers", kind)))
        if callback is None:
            callback = self.primitive_name(kind)
            self.primitives[kind] = callback
        call = f"field(d, record, {name}, {self.quote(kind)}, {callback})"
        return [f"set(d, scope, {name}, {call});" if retain else call + ";"]

    def primitive_name(self, kind):
        import re

        return "primitive_" + re.sub("[^a-zA-Z0-9]", "_", kind)

    def version(self, name, version):
        return [f"version(d, record, {name}, {version});"]

    def call_layout(self, name, params):
        return [
            f'push(d, get(record, "layouts"), {self.literal(name)});',
            *[f"set(d, scope, {self.quote(k)}, {self.literal(v)});" for k, v in params.items()],
            f'{self.names["layouts",name]}(d, record, scope);',
        ]

    def select(self, tag, cases):
        lines = []
        for key, body in cases:
            lines += [
                ("if" if not lines else "} else if") + f" (!strcmp({tag}, {self.quote(key)})) {{",
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
            f"const uint64_t {n} = sizevalue(d, {count}, 1000000);",
            f"for (uint64_t {i} = 0; {i} < {n}; ++{i}) {{",
            *indent(body),
            "}",
        ]

    def signature(self, name, layout=False):
        return (
            f"static void {name}(cr_document* d, J* record, J* scope)"
            if layout
            else f"static J* {name}(cr_document* d)"
        )

    def function(self, name, body, layout=False):
        if layout:
            body = ["enter_layout(d);", *body, "--d->depth;"]
        signature = self.signature(name, layout)
        self.prototypes.append(signature + ";")
        return "\n".join([signature + " {", *indent(body), "}", ""])

    def object(self, kind, definition, body):
        return [
            f'return object(d, {self.quote(kind)}, {self.quote(definition.get("decoration",""))}, {int(definition.get("shared",False))}, {body});'
        ]

    def container(self, definition):
        shape = definition["kind"]
        lines = [
            f'decoration(d, \'{ {"vector":"V","map":"D","pair":"p"}[shape] }\');',
            "J* result = node(d, ARRAY);",
        ]
        if shape == "pair":
            return (
                lines
                + [
                    f"push(d, result, {self.read(definition[slot])});"
                    for slot in ("first", "second")
                ]
                + ["return result;"]
            )
        lines += [
            'const uint64_t n = sizevalue(d, number(d, "casadi_int"), 1000000);',
            "for (uint64_t i = 0; i < n; ++i) {",
        ]
        if shape == "vector":
            body = [f'push(d, result, {self.read(definition["element"])});']
        else:
            body = [
                "J* entry = node(d, ARRAY);",
                *[f"push(d, entry, {self.read(definition[slot])});" for slot in ("key", "value")],
                "push(d, result, entry);",
            ]
        return (
            lines
            + indent(body)
            + ["}", 'return wrapped(d, "$map", result);' if shape == "map" else "return result;"]
        )

    def generate(self):
        self.prototypes = []
        self.primitives = {}
        functions = self.functions()
        for kind, name in self.primitives.items():
            functions.insert(0, self.function(name, [f"return {self.primitive(kind)};"]))
        dispatch = ["static J* value(cr_document* d, const char* type) {"]
        for (group, kind), name in self.names.items():
            if group != "layouts":
                dispatch += [f"    if (!strcmp(type, {self.quote(kind)})) return {name}(d);"]
        dispatch += ["    return primitive(d, type);", "}"]
        return (
            "/* Generated from serialization_scheme.json; do not edit. */\n"
            + "\n".join(self.prototypes + [""] + functions + dispatch)
            + "\n"
        )
