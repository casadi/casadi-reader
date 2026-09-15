"""Prepare explicit wire types and retained field references for code generation."""

import copy


def reader_model(scheme):
    data = copy.deepcopy(
        {
            "wire": {key: scheme["wire"][key] for key in ("magic", "protocol")},
            "reader": scheme["reader"],
        }
    )
    containers = {}
    fields = set()
    dynamic_fields = False

    def type_name(descriptor):
        if isinstance(descriptor, str):
            return descriptor
        name = descriptor["name"]
        slots = {
            "std::vector": ("element",),
            "std::map": ("key", "value"),
            "std::pair": ("first", "second"),
        }[name]
        arguments = {slot: type_name(descriptor[slot]) for slot in slots}
        key = name + "<" + ",".join(arguments.values()) + ">"
        containers[key] = {"kind": name[5:], **arguments}
        return key

    def references(value):
        nonlocal dynamic_fields
        if isinstance(value, list):
            if len(value) == 2 and value[0] == "field":
                if isinstance(value[1], str):
                    fields.add(value[1])
                else:
                    dynamic_fields = True
            for child in value:
                references(child)
        elif isinstance(value, dict):
            for child in value.values():
                references(child)

    references(data)

    def visit(value):
        if isinstance(value, list):
            for child in value:
                visit(child)
        elif isinstance(value, dict):
            if value.get("op") == "field":
                if value.get("type"):
                    value["type"] = type_name(value["type"])
                if dynamic_fields or value.get("name") in fields:
                    value["retain"] = True
            for child in value.values():
                visit(child)

    visit(data)
    for key in ("file_types", "file_prefixes"):
        data["reader"][key] = {
            tag: type_name(kind) for tag, kind in data["reader"].get(key, {}).items()
        }
    containers["Dict"] = {"kind": "map", "key": "std::string", "value": "GenericType"}
    data["reader"]["containers"] = containers
    return data
