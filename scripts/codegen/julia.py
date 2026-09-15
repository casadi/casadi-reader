from .base import Emitter, indent
import json


class Julia(Emitter):
    def literal(self, value):
        if value is None:
            return "nothing"
        if isinstance(value, dict):
            return (
                "Dict("
                + ", ".join(self.literal(k) + " => " + self.literal(v) for k, v in value.items())
                + ")"
            )
        return json.dumps(value).replace("$", r"\$")

    def lookup(self, name):
        return f"scope[{name}]"

    def operator(self, op, args):
        a = args[0]
        if op == "length":
            return f"length({a})"
        if op == "not":
            return f"(!truth({a}))"
        b = args[1]
        if op == "concat":
            return f"(string({a}) * string({b}))"
        if op in ("and", "or"):
            return f"(truth({a}) " + {"and": "&&", "or": "||"}[op] + f" truth({b}))"
        return f"({a} " + {"equal": "==", "not_equal": "!="}[op] + f" {b})"

    def invoke(self, name):
        return f"{name}(r)"

    def primitive(self, kind):
        q = self.literal(kind)
        if kind in ("int", "unsignedint", "casadi_int", "size_t", "double"):
            return f"number(r, {q})"
        return {
            "char": "byte(r)",
            "bool": "boolvalue(r)",
            "std::string": "stringvalue(r)",
            "std::istream": "streamvalue(r)",
            "std::stringstream": "streamvalue(r)",
        }.get(kind, f"primitive(r, {q})")

    def assign(self, name, value):
        return [f"{name} = {value}"]

    def tag(self, value):
        return f"string({value})"

    def failure(self, reason):
        return [f"fail(r, {self.literal(reason)})"]

    def field(self, name, kind, retain):
        call = f"field(r, record, {name}, {self.literal(kind)}, () -> {self.read(kind)})"
        return [(f"scope[{name}] = " if retain else "") + call]

    def version(self, name, version):
        return [f"version(r, record, {name}, {version})"]

    def call_layout(self, name, params):
        return [
            f'push!(record["layouts"], {self.literal(name)})',
            *[f"scope[{self.literal(k)}] = {self.literal(v)}" for k, v in params.items()],
            f'{self.names["layouts",name]}(r, record, scope)',
        ]

    def branch(self, condition, yes, no):
        lines = [f"if truth({condition})", *indent(yes)]
        if no:
            lines += ["else", *indent(no)]
        return lines + ["end"]

    def select(self, tag, cases):
        lines = []
        for key, body in cases:
            lines += [
                ("if" if not lines else "elseif") + f" {tag} == {self.literal(key)}",
                *indent(body),
            ]
        return (
            lines + ["else", *indent(self.failure("Unknown serialization discriminator")), "end"]
            if lines
            else self.failure("Unknown serialization discriminator")
        )

    def repeat(self, count, body):
        return [f"for _ in 1:count(r, {count})", *indent(body), "end"]

    def function(self, name, body, layout=False):
        if layout:
            body = ["enter_layout(r)", *body, "r.depth -= 1"]
        return "\n".join(
            [
                f"function {name}(r" + (", record, scope" if layout else "") + ")",
                *indent(body),
                "end",
                "",
            ]
        )

    def object(self, kind, definition, body):
        return [
            f'return object(r, {self.literal(kind)}, {self.literal(definition.get("decoration"))}, {self.literal(definition.get("shared",False))}, {body})'
        ]

    def container(self, definition):
        shape = definition["kind"]
        lines = [f'decoration(r, {self.literal({"vector":"V","map":"D","pair":"p"}[shape])})']
        if shape == "pair":
            return lines + [
                f'return Any[{self.read(definition["first"])}, {self.read(definition["second"])}]'
            ]
        expr = (
            self.read(definition["element"])
            if shape == "vector"
            else f'Any[{self.read(definition["key"])}, {self.read(definition["value"])}]'
        )
        result = f'Any[{expr} for _ in 1:count(r, number(r, "casadi_int"))]'
        return lines + [
            "return " + (result if shape == "vector" else 'Dict("\\$map" => ' + result + ")")
        ]

    def generate(self):
        functions = self.functions()
        registry = {k: n for (g, k), n in self.names.items() if g != "layouts"}
        return (
            "# Generated from serialization_scheme.json; do not edit.\n\n"
            + "\n".join(functions)
            + "\nconst READERS = Dict(\n"
            + "".join(f"    {self.literal(k)} => {v},\n" for k, v in registry.items())
            + ")\nconst METADATA = "
            + self.literal(self.metadata())
            + "\n"
        )
