"""Compile scheme layouts to native control flow; never emit instruction tables."""

import re


class Emitter:
    def __init__(self, data):
        self.data = data
        self.reader = data["reader"]

        def calls(value):
            if isinstance(value, list):
                for child in value:
                    yield from calls(child)
            elif isinstance(value, dict):
                if value.get("op") == "call":
                    yield value["layout"]
                for child in value.values():
                    yield from calls(child)

        missing = set(calls(self.reader)) - self.reader["layouts"].keys()
        for name in sorted(missing):
            self.reader["layouts"][name] = [
                {"op": "unsupported", "reason": "Serialization layout absent from scheme: " + name}
            ]
        self.names = {}
        used = set()
        for group in ("layouts", "types", "containers"):
            for name in self.reader[group]:
                stem = ("layout_" if group == "layouts" else "read_") + re.sub(
                    r"[^a-zA-Z0-9]+", "_", name
                ).strip("_")
                candidate = stem
                i = 2
                while candidate in used:
                    candidate = stem + "_" + str(i)
                    i += 1
                used.add(candidate)
                self.names[group, name] = candidate
        self.serial = 0

    def fresh(self, stem):
        self.serial += 1
        return stem + "_" + str(self.serial)

    def name(self, step):
        return (
            self.literal(step["name"])
            if step.get("name") is not None
            else self.expr(step["name_expression"])
        )

    def condition(self, operand):
        return self.expr(operand)

    def expr(self, operand):
        op, *args = operand
        if op == "literal":
            return self.literal(args[0])
        if op in ("field", "parameter"):
            name = self.literal(args[0]) if isinstance(args[0], str) else self.expr(args[0])
            return self.lookup(name)
        return self.operator(op, [self.expr(a) for a in args])

    def steps(self, steps):
        lines = []
        for step in steps:
            op = step["op"]
            if op == "field":
                if not step.get("type"):
                    lines += self.failure("Unresolved serialization type")
                else:
                    lines += self.field(self.name(step), step["type"], step.get("retain", False))
            elif op == "version":
                lines += self.version(self.name(step), step["value"])
            elif op == "call":
                lines += self.call_layout(step["layout"], step.get("params", {}))
            elif op == "if":
                lines += self.branch(
                    self.condition(step["condition"]),
                    self.steps(step["body"]),
                    self.steps(step.get("else", [])),
                )
            elif op == "repeat":
                lines += self.repeat(self.expr(step["count"]), self.steps(step["body"]))
            elif op == "select":
                tag = self.fresh("tag")
                lines += self.assign(tag, self.tag(self.expr(step["value"])))
                lines += self.select(
                    tag, [(key, self.steps(body)) for key, body in step["cases"].items()]
                )
            elif op == "unsupported":
                lines += self.failure(step.get("reason", "Unsupported serialization layout"))
            else:
                raise ValueError("Unknown scheme instruction: " + op)
        return lines

    def read(self, kind):
        for group in ("types", "containers"):
            if (group, kind) in self.names:
                return self.invoke(self.names[group, kind])
        return self.primitive(kind)

    def functions(self):
        result = []
        for name, steps in self.reader["layouts"].items():
            result.append(
                self.function(self.names["layouts", name], self.steps(steps), layout=True)
            )
        for kind, definition in self.reader["types"].items():
            body_name = self.names["types", kind] + "_body"
            result.append(self.function(body_name, self.steps(definition["body"]), layout=True))
            result.append(
                self.function(self.names["types", kind], self.object(kind, definition, body_name))
            )
        for kind, definition in self.reader["containers"].items():
            result.append(self.function(self.names["containers", kind], self.container(definition)))
        return result

    def metadata(self):
        return {
            "wire": self.data["wire"],
            "reader": {key: self.reader[key] for key in ("file_types", "file_prefixes")},
        }


def indent(lines, n=1, width=4):
    return [(" " * n * width + line) if line else "" for line in lines]
