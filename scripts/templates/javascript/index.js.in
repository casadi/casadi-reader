import { readers, metadata } from "./generated.js";
import {
  EncodedSource,
  LazyBlob,
  LazyFileBlob,
  PagedSource,
  MissingPage,
} from "./source.js";

// Shared binary primitives and object/reference bookkeeping.
// Concrete object layouts and polymorphic selectors are generated from CasADi.
class Reader {
  constructor(text, options) {
    this.scheme = metadata;
    if (options.scheme)
      throw Error("Generate a reader for a custom scheme before decoding");
    this.source = new EncodedSource(text, options);
    this.pos = 0;
    this.objects = [];
    this.shared = [];
    this.debug = false;
    this.lazy = !!options.lazy;
    this.depth = 0;
    this.maxItems = options.maxItems ?? 1000000;
    this.lazyThreshold = options.lazyThreshold ?? 65536;
  }
  fail(message) {
    throw Error(`.casadi byte ${this.pos}: ${message}`);
  }
  take(n) {
    if (
      !Number.isSafeInteger(n) ||
      n < 0 ||
      n > this.source.byteLength - this.pos
    )
      this.fail("Truncated or excessive payload");
    const p = this.pos;
    this.pos += n;
    return p;
  }
  count(n) {
    if (!Number.isSafeInteger(n) || n < 0 || n > this.maxItems)
      this.fail("Invalid or excessive collection size");
    return n;
  }
  byte() {
    return this.source.byte(this.take(1));
  }
  decoration(tag) {
    if (this.debug && this.byte() !== tag.charCodeAt(0))
      this.fail("Expected wire decoration " + tag);
  }
  name(name) {
    if (this.debug && this.string() !== name)
      this.fail("Expected serialized field " + name);
  }
  number(type) {
    this.decoration(
      { int: "i", unsignedint: "u", casadi_int: "J", size_t: "K", double: "d" }[
        type
      ],
    );
    const sizes = {
      int: 4,
      unsignedint: 4,
      casadi_int: 8,
      size_t: 8,
      double: 8,
    };
    const n = sizes[type],
      view = this.source.view(this.take(n), n);
    if (type === "double") {
      const value = view.getFloat64(0, true);
      return Number.isFinite(value) ? value : { $float: String(value) };
    }
    if (type === "int") return view.getInt32(0, true);
    if (type === "unsignedint") return view.getUint32(0, true);
    const value =
      type === "size_t"
        ? view.getBigUint64(0, true)
        : view.getBigInt64(0, true);
    return value > BigInt(Number.MAX_SAFE_INTEGER) ||
      value < BigInt(Number.MIN_SAFE_INTEGER)
      ? { $integer: String(value) }
      : Number(value);
  }
  string() {
    this.decoration("s");
    const n = this.number("int"),
      offset = this.take(n);
    if (this.lazy && n >= this.lazyThreshold)
      return new LazyBlob(this.source, offset, n);
    const bytes = this.source.read(offset, n);
    try {
      return new TextDecoder("utf8", { fatal: true }).decode(bytes);
    } catch {
      return this.lazy
        ? new LazyBlob(this.source, offset, n)
        : { $bytes: Array.from(bytes) };
    }
  }
  enterLayout() {
    if (++this.depth > 256) this.fail("Layout nesting limit exceeded");
  }
  field(record, name, type, read) {
    this.name(name);
    const value = read();
    record.fields.push({ name, type, value });
    this.count(record.fields.length);
    return value;
  }
  version(record, base, expected) {
    const value = this.field(
      record,
      base + "::serialization::version",
      "int",
      () => this.number("int"),
    );
    if (value !== expected) this.fail(`Unsupported ${base} version ${value}`);
  }
  value(type) {
    return Object.hasOwn(readers, type)
      ? readers[type](this)
      : this.primitive(type);
  }
  primitive(cppType) {
    const type = cppType;
    if (["int", "unsignedint", "casadi_int", "size_t", "double"].includes(type))
      return this.number(type);
    if (type === "char") return this.byte();
    if (type === "bool") return this.boolean();
    if (type === "std::string") return this.string();
    if (type === "std::istream" || type === "std::stringstream")
      return this.stream();
    this.fail("Unknown serialization type: " + type);
  }
  boolean() {
    this.decoration("b");
    const b = this.byte();
    if (b > 1) this.fail("Invalid boolean");
    return !!b;
  }
  stream() {
    this.decoration("B");
    const n = this.number("size_t"),
      offset = this.take(n);
    return this.lazy
      ? new LazyBlob(this.source, offset, n)
      : { $bytes: Array.from(this.source.read(offset, n)) };
  }
  object(type, decoration, shared, read) {
    if (decoration) this.decoration(decoration);
    if (shared) {
      this.name("Shared::flag");
      const flag = this.byte();
      if (flag === 114) {
        this.name("Shared::reference");
        const id = this.number("casadi_int");
        if (!Number.isSafeInteger(id) || id < 0 || id >= this.shared.length)
          this.fail("Invalid shared reference");
        return { $ref: this.shared[id] };
      }
      if (flag !== 100) this.fail("Invalid shared definition");
    }
    const record = { type, fields: [], layouts: [] };
    read(this, record, Object.create(null));
    if (!shared) return record;
    this.count(this.objects.length + 1);
    const id = this.objects.length;
    this.objects.push(record);
    this.shared.push(id);
    return { $ref: id };
  }
  decode(options) {
    if (this.number("casadi_int") !== this.scheme.wire.magic)
      this.fail("Invalid serialization magic");
    if (this.number("casadi_int") !== this.scheme.wire.protocol)
      this.fail("Unsupported serialization protocol");
    const debug = this.byte();
    if (debug > 1) this.fail("Invalid debug flag");
    this.debug = !!debug;
    const roots = [];
    if (options.type) roots.push(this.value(options.type));
    else
      while (this.pos < this.source.byteLength) {
        const tag = this.byte(),
          type = this.scheme.reader.file_types?.[tag];
        if (!type) this.fail("Unsupported serialized file type " + tag);
        const prefix = this.scheme.reader.file_prefixes?.[tag];
        if (prefix) this.value(prefix);
        roots.push(this.value(type));
      }
    if (this.pos !== this.source.byteLength)
      this.fail("Trailing serialization data");
    return {
      format: "casadi_serialization",
      version: 1,
      serializationProtocol: this.scheme.wire.protocol,
      root:
        roots.length === 1 && Object.hasOwn(roots[0], "$ref")
          ? roots[0].$ref
          : null,
      roots,
      objects: this.objects,
    };
  }
}
/** Read serialized structure. No graph interpretation, plugin loading or evaluation. */
export function decode(text, options = {}) {
  return new Reader(text, options).decode(options);
}
/** Open an unpadded File/Blob; lazy mode reads only metadata pages. */
export async function open(file, options = {}) {
  if (!options.lazy) return decode(await file.text(), options);
  const source = new PagedSource(file.size, options);
  for (;;) {
    const reader = new Reader("", options);
    reader.source = source;
    try {
      const document = reader.decode(options);
      const convert = (value) => {
        if (value instanceof LazyBlob)
          return new LazyFileBlob(file, value.offset, value.byteLength);
        if (Array.isArray(value)) return value.map(convert);
        if (value && typeof value === "object")
          for (const key of Object.keys(value))
            value[key] = convert(value[key]);
        return value;
      };
      return convert(document);
    } catch (error) {
      if (!(error instanceof MissingPage)) throw error;
      const start = error.index * source.pageBytes * 2;
      const text = await file
        .slice(start, Math.min(file.size, start + source.pageBytes * 2))
        .text();
      // Preserve page boundaries; unlike complete text inputs they must not trim.
      if (text.length % 2 || /[^a-p]/.test(text))
        throw Error("Invalid .casadi encoding in file page");
      source.pages.set(error.index, new EncodedSource(text, { lazy: true }));
    }
  }
}
export { LazyBlob };
export const decodeCasadi = decode;
