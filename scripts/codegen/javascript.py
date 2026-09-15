from .base import Emitter, indent
import json


class JavaScript(Emitter):
    literal = staticmethod(json.dumps)

    def lookup(self, name):
        return f"scope[{name}]"

    def operator(self, op, args):
        a = args[0]
        if op == "length":
            return f"{a}.length"
        if op == "not":
            return f"(!{a})"
        b = args[1]
        if op == "concat":
            return f"(String({a}) + String({b}))"
        return (
            f"({a} " + {"equal": "===", "not_equal": "!==", "and": "&&", "or": "||"}[op] + f" {b})"
        )

    def invoke(self, name):
        return f"{name}(r)"

    def primitive(self, kind):
        q = self.literal(kind)
        if kind in ("int", "unsignedint", "casadi_int", "size_t", "double"):
            return f"r.number({q})"
        return {
            "char": "r.byte()",
            "bool": "r.boolean()",
            "std::string": "r.string()",
            "std::istream": "r.stream()",
            "std::stringstream": "r.stream()",
        }.get(kind, f"r.primitive({q})")

    def assign(self, name, value):
        return [f"const {name} = {value};"]

    def tag(self, value):
        return f"String({value})"

    def failure(self, reason):
        return [f"r.fail({self.literal(reason)});"]

    def field(self, name, kind, retain):
        call = f"r.field(record, {name}, {self.literal(kind)}, () => {self.read(kind)})"
        return [(f"scope[{name}] = " if retain else "") + call + ";"]

    def version(self, name, version):
        return [f"r.version(record, {name}, {version});"]

    def call_layout(self, name, params):
        return [
            f"record.layouts.push({self.literal(name)});",
            *[f"scope[{self.literal(k)}] = {self.literal(v)};" for k, v in params.items()],
            f'{self.names["layouts",name]}(r, record, scope);',
        ]

    def branch(self, condition, yes, no):
        lines = [f"if ({condition}) {{", *indent(yes)]
        if no:
            lines += ["} else {", *indent(no)]
        return lines + ["}"]

    def select(self, tag, cases):
        lines = [f"switch ({tag}) {{"]
        for key, body in cases:
            lines += [f"case {self.literal(key)}: {{", *indent(body), "    break;", "}"]
        return lines + [
            "default:",
            *indent(self.failure("Unknown serialization discriminator")),
            "}",
        ]

    def repeat(self, count, body):
        n, i = self.fresh("count"), self.fresh("i")
        return [
            f"const {n} = r.count({count});",
            f"for (let {i} = 0; {i} < {n}; ++{i}) {{",
            *indent(body),
            "}",
        ]

    def function(self, name, body, layout=False):
        if layout:
            body = ["r.enterLayout();", *body, "--r.depth;"]
        return "\n".join(
            [
                f"function {name}(r" + (", record, scope" if layout else "") + ") {",
                *indent(body),
                "}",
                "",
            ]
        )

    def object(self, kind, definition, body):
        return [
            f'return r.object({self.literal(kind)}, {self.literal(definition.get("decoration"))}, {self.literal(definition.get("shared",False))}, {body});'
        ]

    def container(self, definition):
        shape = definition["kind"]
        lines = [f'r.decoration({self.literal({"vector":"V","map":"D","pair":"p"}[shape])});']
        if shape == "pair":
            return lines + [
                f'return [{self.read(definition["first"])}, {self.read(definition["second"])}];'
            ]
        expr = (
            self.read(definition["element"])
            if shape == "vector"
            else f'[{self.read(definition["key"])}, {self.read(definition["value"])}]'
        )
        result = f'Array.from({{length: r.count(r.number("casadi_int"))}}, () => {expr})'
        return lines + [
            "return " + (result if shape == "vector" else "{$map: " + result + "}") + ";"
        ]

    def generate(self):
        functions = self.functions()
        registry = {k: n for (g, k), n in self.names.items() if g != "layouts"}
        return (
            "// Generated from serialization_scheme.json; do not edit.\n\n"
            + "\n".join(functions)
            + "\nexport const readers = {\n"
            + "".join(f"  {self.literal(k)}: {v},\n" for k, v in registry.items())
            + "};\nexport const metadata = "
            + json.dumps(self.metadata(), indent=2)
            + ";\n"
        )
