"""Generated structural reader. Edit scripts/templates/python/reader.py.in."""

import json
import math
import mmap
import struct
from ._generated import READERS, METADATA


class Source:
    """A text string or read-only mapping; payload pages need not be read."""

    def __init__(self, text=None, path=None, max_bytes=1024**3):
        self.mapping = None
        self.closed = False
        if path is not None:
            with open(path, "rb") as stream:
                self.mapping = mmap.mmap(stream.fileno(), 0, access=mmap.ACCESS_READ)
            self.data = self.mapping
        else:
            if not isinstance(text, str):
                raise TypeError("Expected serialized text")
            self.data = text
        self.start, end = 0, len(self.data)
        whitespace = (" ", "\t", "\r", "\n", 32, 9, 13, 10)
        while self.start < end and self.data[self.start] in whitespace:
            self.start += 1
        while end > self.start and self.data[end - 1] in whitespace:
            end -= 1
        if (end - self.start) % 2 or (end - self.start) // 2 > max_bytes:
            self.close()
            raise ValueError("Invalid .casadi encoding or file too large")
        self.byte_length = (end - self.start) // 2
        self.decoded_bytes = 0

    def byte(self, offset):
        if self.closed:
            raise ValueError("Source is closed")
        if not 0 <= offset < self.byte_length:
            raise ValueError("Encoded source offset out of bounds")
        a, b = self.data[self.start + 2 * offset : self.start + 2 * offset + 2]
        if isinstance(a, str):
            a, b = ord(a), ord(b)
        a, b = a - 97, b - 97
        if not (0 <= a <= 15 and 0 <= b <= 15):
            raise ValueError("Invalid .casadi encoding at byte " + str(offset))
        self.decoded_bytes += 1
        return a | (b << 4)

    def read(self, offset, size):
        if size < 0 or offset < 0 or offset + size > self.byte_length:
            raise ValueError("Encoded source range out of bounds")
        return bytes(self.byte(offset + i) for i in range(size))

    def close(self):
        self.closed = True
        if self.mapping is not None:
            self.mapping.close()
            self.mapping = None

    def __del__(self):
        self.close()


class LazyBlob:
    """Retains the encoded source; read() decodes only the requested range."""

    def __init__(self, source, offset, byte_length):
        self._source, self.offset, self.byte_length = source, offset, byte_length

    def read(self, offset=0, size=None):
        size = self.byte_length - offset if size is None else size
        if offset < 0 or size < 0 or offset + size > self.byte_length:
            raise ValueError("Blob slice out of bounds")
        return self._source.read(self.offset + offset, size)

    def to_dict(self):
        return {
            "kind": "deferred_bytes",
            "offset": self.offset,
            "byteLength": self.byte_length,
            "encoding": "casadi-nibbles",
        }

    def close(self):
        """Release the mapped file; subsequent reads through its handles fail."""
        self._source.close()


class Reader:
    def __init__(self, source, *, lazy=False, max_items=1000000, lazy_threshold=65536):
        self.source, self.lazy = source, lazy
        self.scheme = METADATA
        self.max_items, self.lazy_threshold = max_items, lazy_threshold
        self.pos, self.depth, self.debug = 0, 0, False
        self.shared, self.objects = [], []

    def fail(self, message):
        raise ValueError(f".casadi byte {self.pos}: {message}")

    def take(self, size):
        if not isinstance(size, int) or size < 0 or size > self.source.byte_length - self.pos:
            self.fail("Truncated or excessive payload")
        start, self.pos = self.pos, self.pos + size
        return start

    def count(self, value):
        if not isinstance(value, int) or not 0 <= value <= self.max_items:
            self.fail("Invalid or excessive collection size")
        return value

    def byte(self):
        return self.source.byte(self.take(1))

    def decoration(self, tag):
        if self.debug and self.byte() != ord(tag):
            self.fail("Expected wire decoration " + tag)

    def name(self, name):
        if self.debug and self.string() != name:
            self.fail("Expected serialized field " + name)

    def number(self, kind):
        tag, fmt, size = {
            "int": ("i", "i", 4),
            "unsignedint": ("u", "I", 4),
            "casadi_int": ("J", "q", 8),
            "size_t": ("K", "Q", 8),
            "double": ("d", "d", 8),
        }[kind]
        self.decoration(tag)
        value = struct.unpack("<" + fmt, self.source.read(self.take(size), size))[0]
        if kind == "double":
            if not math.isfinite(value):
                return {
                    "$float": (
                        "NaN" if math.isnan(value) else "Infinity" if value > 0 else "-Infinity"
                    )
                }
        elif abs(value) > 9007199254740991:
            return {"$integer": str(value)}
        return value

    def string(self):
        self.decoration("s")
        size = self.number("int")
        offset = self.take(size)
        if self.lazy and size >= self.lazy_threshold:
            return LazyBlob(self.source, offset, size)
        data = self.source.read(offset, size)
        try:
            return data.decode("utf8")
        except UnicodeDecodeError:
            return LazyBlob(self.source, offset, size) if self.lazy else {"$bytes": list(data)}

    def enter_layout(self):
        self.depth += 1
        if self.depth > 256:
            self.fail("Layout nesting limit exceeded")

    @staticmethod
    def tag(value):
        return str(value).lower() if isinstance(value, bool) else str(value)

    def field(self, record, name, kind, read):
        self.name(name)
        value = read()
        record["fields"].append(dict(name=name, type=kind, value=value))
        self.count(len(record["fields"]))
        return value

    def version(self, record, base, expected):
        value = self.field(
            record, base + "::serialization::version", "int", lambda: self.number("int")
        )
        if value != expected:
            self.fail("Unsupported " + base + " version " + str(value))

    def value(self, kind):
        read = READERS.get(kind)
        return read(self) if read else self.primitive(kind)

    def primitive(self, cpp_type):
        kind = cpp_type
        if kind in ("int", "unsignedint", "casadi_int", "size_t", "double"):
            return self.number(kind)
        if kind == "char":
            return self.byte()
        if kind == "bool":
            return self.boolean()
        if kind == "std::string":
            return self.string()
        if kind in ("std::istream", "std::stringstream"):
            return self.stream()
        self.fail("Unknown serialization type: " + kind)

    def boolean(self):
        self.decoration("b")
        value = self.byte()
        if value > 1:
            self.fail("Invalid boolean")
        return bool(value)

    def stream(self):
        self.decoration("B")
        size = self.number("size_t")
        offset = self.take(size)
        return (
            LazyBlob(self.source, offset, size)
            if self.lazy
            else {"$bytes": list(self.source.read(offset, size))}
        )

    def object(self, kind, decoration, shared, read):
        if decoration:
            self.decoration(decoration)
        if shared:
            self.name("Shared::flag")
            flag = self.byte()
            if flag == ord("r"):
                self.name("Shared::reference")
                index = self.number("casadi_int")
                if not isinstance(index, int) or not 0 <= index < len(self.shared):
                    self.fail("Invalid shared reference")
                return {"$ref": self.shared[index]}
            if flag != ord("d"):
                self.fail("Invalid shared definition")
        record = dict(type=kind, fields=[], layouts=[])
        read(self, record, {})
        if not shared:
            return record
        self.count(len(self.objects) + 1)
        index = len(self.objects)
        self.objects.append(record)
        self.shared.append(index)
        return {"$ref": index}

    def decode(self, type=None):
        if self.number("casadi_int") != self.scheme["wire"]["magic"]:
            self.fail("Invalid serialization magic")
        if self.number("casadi_int") != self.scheme["wire"]["protocol"]:
            self.fail("Unsupported serialization protocol")
        debug = self.byte()
        if debug > 1:
            self.fail("Invalid debug flag")
        self.debug = bool(debug)
        roots = []
        if type:
            roots.append(self.value(type))
        else:
            while self.pos < self.source.byte_length:
                tag = self.byte()
                kind = self.scheme["reader"]["file_types"].get(str(tag))
                if not kind:
                    self.fail("Unsupported serialized file type " + str(tag))
                prefix = self.scheme["reader"].get("file_prefixes", {}).get(str(tag))
                if prefix:
                    self.value(prefix)
                roots.append(self.value(kind))
        if self.pos != self.source.byte_length:
            self.fail("Trailing serialization data")
        return dict(
            format="casadi_serialization",
            version=1,
            serializationProtocol=self.scheme["wire"]["protocol"],
            root=roots[0].get("$ref") if len(roots) == 1 and isinstance(roots[0], dict) else None,
            roots=roots,
            objects=self.objects,
        )


def _decode(source, *, type=None, **options):
    try:
        result = Reader(source, **options).decode(type)
        if not options.get("lazy"):
            source.close()
        return result
    except BaseException:
        source.close()
        raise


def loads(text, **options):
    return _decode(Source(text=text), **options)


def read_casadi(path, **options):
    return _decode(Source(path=path), **options)


def loads_resource(text, **options):
    return loads(text, type="Resource", **options)


def read_resource(path, **options):
    return read_casadi(path, type="Resource", **options)


def to_json(document, **options):
    return json.dumps(
        document, default=lambda v: v.to_dict() if isinstance(v, LazyBlob) else v, **options
    )
