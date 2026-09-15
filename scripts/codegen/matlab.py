from .base import Emitter, indent


class Matlab(Emitter):
    def __init__(self, data):
        super().__init__(data)
        # MATLAB identifiers have a 63-character limit, including the body suffix.
        for i, key in enumerate(self.names):
            name = self.names[key]
            if len(name) > 52:
                self.names[key] = name[:44] + "_" + str(i)

    def literal(self, value):
        if value is None:
            return "[]"
        if isinstance(value, bool):
            return str(value).lower()
        if isinstance(value, str):
            return "'" + value.replace("'", "''") + "'"
        return str(value)

    def lookup(self, name):
        return f"scope({name})"

    def operator(self, op, args):
        a = args[0]
        if op == "length":
            return f"numel({a})"
        if op == "not":
            return f"(~self.truth({a}))"
        b = args[1]
        if op == "concat":
            return f"[{a} {b}]"
        if op in ("equal", "not_equal"):
            return ("~" if op == "not_equal" else "") + f"isequal({a}, {b})"
        return f"(self.truth({a}) " + {"and": "&&", "or": "||"}[op] + f" self.truth({b}))"

    def invoke(self, name):
        return f"self.{name}()"

    def primitive(self, kind):
        q = self.literal(kind)
        if kind in ("int", "unsignedint", "casadi_int", "size_t", "double"):
            return f"self.number({q})"
        return {
            "char": "self.byte()",
            "bool": "self.boolValue()",
            "std::string": "self.stringValue()",
            "std::istream": "self.streamValue()",
            "std::stringstream": "self.streamValue()",
        }.get(kind, f"self.primitive({q})")

    def assign(self, name, value):
        return [f"{name} = {value};"]

    def tag(self, value):
        return f"self.tag({value})"

    def failure(self, reason):
        return [f"self.fail({self.literal(reason)});"]

    def field(self, name, kind, retain):
        call = f"self.field(record, {name}, {self.literal(kind)}, @() {self.read(kind)})"
        return [(f"scope({name}) = " if retain else "") + call + ";"]

    def version(self, name, version):
        return [f"self.version(record, {name}, {version});"]

    def call_layout(self, name, params):
        return [
            f"self.recordLayout(record, {self.literal(name)});",
            *[f"scope({self.literal(k)}) = {self.literal(v)};" for k, v in params.items()],
            f'self.{self.names["layouts",name]}(record, scope);',
        ]

    def branch(self, condition, yes, no):
        lines = [f"if self.truth({condition})", *indent(yes)]
        if no:
            lines += ["else", *indent(no)]
        return lines + ["end"]

    def select(self, tag, cases):
        lines = [f"switch {tag}"]
        for key, body in cases:
            lines += [f"    case {self.literal(key)}", *indent(body, 2)]
        return lines + [
            "    otherwise",
            *indent(self.failure("Unknown serialization discriminator"), 2),
            "end",
        ]

    def repeat(self, count, body):
        return [f'for {self.fresh("i")} = 1:self.count({count})', *indent(body), "end"]

    def function(self, name, body, layout=False):
        if layout:
            body = ["self.enterLayout();", *body, "self.depth = self.depth - 1;"]
        signature = (
            f"function {name}(self, record, scope)" if layout else f"function v = {name}(self)"
        )
        return "\n".join([signature, *indent(body), "end", ""])

    def object(self, kind, definition, body):
        return [
            f'v = self.readObject({self.literal(kind)}, {self.literal(definition.get("decoration", ""))}, {self.literal(definition.get("shared",False))}, @(record, scope) self.{body}(record, scope));'
        ]

    def container(self, definition):
        shape = definition["kind"]
        lines = [f'self.decoration({self.literal({"vector":"V","map":"D","pair":"p"}[shape])});']
        if shape == "pair":
            return lines + [
                f'v = {{{self.read(definition["first"])}, {self.read(definition["second"])}}};'
            ]
        expr = (
            self.read(definition["element"])
            if shape == "vector"
            else f'{{{self.read(definition["key"])}, {self.read(definition["value"])}}}'
        )
        lines += [
            "n = self.count(self.number('casadi_int'));",
            "v = cell(1, n);",
            "for i = 1:n",
            f"    v{{i}} = {expr};",
            "end",
        ]
        if shape == "map":
            lines += ["v = self.object({'$map'}, {v});"]
        return lines

    def generate(self):
        functions = self.functions()
        dispatch = ["function v = value(self, kind)", "    switch kind"]
        for (group, kind), name in self.names.items():
            if group != "layouts":
                dispatch += [
                    f"        case {self.literal(kind)}",
                    f"            v = self.{name}();",
                ]
        dispatch += ["        otherwise", "            v = self.primitive(kind);", "    end", "end"]
        return "\n".join(functions + dispatch)

    def metadata_source(self):
        def literal(value):
            if isinstance(value, dict):
                return (
                    "containers.Map({"
                    + ", ".join(self.literal(k) for k in value)
                    + "}, {"
                    + ", ".join(literal(v) for v in value.values())
                    + "})"
                )
            return self.literal(value)

        return (
            "% Generated wire metadata.\nfunction value = metadata()\nvalue = "
            + literal(self.metadata())
            + ";\nend\n"
        )
