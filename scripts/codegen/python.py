from .base import Emitter, indent
import pprint


class Python(Emitter):
    literal = staticmethod(repr)

    def lookup(self, name):
        return f"scope[{name}]"

    def operator(self, op, args):
        a = args[0]
        if op == "length":
            return f"len({a})"
        if op == "not":
            return f"(not {a})"
        b = args[1]
        if op == "concat":
            return f"(str({a}) + str({b}))"
        return (
            f"({a} " + {"equal": "==", "not_equal": "!=", "and": "and", "or": "or"}[op] + f" {b})"
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
        return [f"{name} = {value}"]

    def tag(self, value):
        return f"r.tag({value})"

    def compare_tag(self, tag, key):
        return f"{tag} == {key!r}"

    def failure(self, reason):
        return [f"r.fail({reason!r})"]

    def field(self, name, kind, retain):
        # Reading the name first matters for debug streams.
        call = f"r.field(record, {name}, {kind!r}, {self.read_callback(kind)})"
        return [f"scope[{name}] = {call}" if retain else call]

    def read_callback(self, kind):
        return f"lambda: {self.read(kind)}"

    def version(self, name, version):
        return [f"r.version(record, {name}, {version})"]

    def call_layout(self, name, params):
        return [
            f'record["layouts"].append({name!r})',
            *[f"scope[{k!r}] = {v!r}" for k, v in params.items()],
            f'{self.names["layouts",name]}(r, record, scope)',
        ]

    def branch(self, condition, yes, no):
        result = [f"if {condition}:", *indent(yes or ["pass"])]
        if no:
            result += ["else:", *indent(no)]
        return result

    def select(self, tag, cases):
        lines = []
        for key, body in cases:
            lines += [
                ("if " if not lines else "elif ") + self.compare_tag(tag, key) + ":",
                *indent(body or ["pass"]),
            ]
        return lines + (
            ["else:", *indent(self.failure("Unknown serialization discriminator"))]
            if lines
            else self.failure("Unknown serialization discriminator")
        )

    def repeat(self, count, body):
        return [f"for _ in range(r.count({count})):", *indent(body or ["pass"])]

    def function(self, name, body, layout=False):
        if layout:
            body = ["r.enter_layout()", *body, "r.depth -= 1"]
        return "\n".join(
            [f"def {name}(r" + (", record, scope" if layout else "") + "):", *indent(body), ""]
        )

    def object(self, kind, definition, body):
        return [
            f'return r.object({kind!r}, {definition.get("decoration")!r}, {definition.get("shared",False)!r}, {body})'
        ]

    def container(self, definition):
        shape = definition["kind"]
        tag = {"vector": "V", "map": "D", "pair": "p"}[shape]
        lines = [f"r.decoration({tag!r})"]
        if shape == "pair":
            return lines + [
                f'return [{self.read(definition["first"])}, {self.read(definition["second"])}]'
            ]
        expr = (
            self.read(definition["element"])
            if shape == "vector"
            else f'[{self.read(definition["key"])}, {self.read(definition["value"])}]'
        )
        result = f'[{expr} for _ in range(r.count(r.number("casadi_int")))]'
        return lines + ["return " + (result if shape == "vector" else '{"$map": ' + result + "}")]

    def generate(self):
        functions = self.functions()
        registry = {k: n for (g, k), n in self.names.items() if g != "layouts"}
        return (
            "# Generated from serialization_scheme.json; do not edit.\n\n"
            + "\n".join(functions)
            + "\nREADERS = {\n"
            + "".join(f"    {k!r}: {v},\n" for k, v in registry.items())
            + "}\nMETADATA = "
            + pprint.pformat(self.metadata(), sort_dicts=True)
            + "\n"
        )
