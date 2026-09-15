// Generated; edit scripts/templates/cpp/runtime.hpp.in.
#pragma once
#include "json.hpp"
#include "metadata.hpp"
#include "source.hpp"
namespace casadi_reader_detail {
const JsonValue& optional(const JsonValue& j, const std::string& key) {
  auto it = j.o.find(key);
  static const JsonValue nil;
  return it == j.o.end() ? nil : it->second;
}
bool truth(const JsonValue& j) {
  return j.kind == JsonValue::Bool     ? j.scalar == "true"
         : j.kind == JsonValue::Number ? j.scalar != "0"
         : j.kind == JsonValue::String ? !j.scalar.empty()
                                       : j.kind != JsonValue::Null;
}
struct Reader {
  std::shared_ptr<EncodedSource> source;
  uint64_t pos = 0;
  int depth = 0;
  bool lazy, debug = false;
  std::vector<int64_t> shared;
  JsonValue objects = JsonValue::array();
  std::vector<ByteRange> blobs;
  Reader(std::shared_ptr<EncodedSource> s, bool l) : source(std::move(s)), lazy(l) {}
  [[noreturn]] void fail(const std::string& s) {
    throw std::runtime_error(".casadi byte " + std::to_string(pos) + ": " + s);
  }
  uint64_t take(uint64_t n) {
    if (n > source->size - pos)
      fail("Truncated or excessive payload");
    auto p = pos;
    pos += n;
    return p;
  }
  uint64_t count(const JsonValue& j) {
    if (j.kind != JsonValue::Number)
      fail("Invalid collection size");
    auto n = j.n();
    if (n < 0 || n > 1000000)
      fail("Invalid or excessive collection size");
    return uint64_t(n);
  }
  uint64_t size(const JsonValue& j) {
    if (j.kind != JsonValue::Number)
      fail("Excessive payload size");
    auto n = j.n();
    if (n < 0)
      fail("Negative payload size");
    return uint64_t(n);
  }
  uint64_t bits(int n) {
    unsigned char bytes[8];
    source->read(take(n), bytes, n);
    uint64_t v = 0;
    for (int i = 0; i < n; ++i)
      v |= uint64_t(bytes[i]) << (8 * i);
    return v;
  }
  int byte() {
    return int(bits(1));
  }
  void decoration(char tag) {
    if (debug && byte() != tag)
      fail(std::string("Expected wire decoration ") + tag);
  }
  JsonValue number(const std::string& type) {
    decoration(type == "int"           ? 'i'
               : type == "unsignedint" ? 'u'
               : type == "casadi_int"  ? 'J'
               : type == "size_t"      ? 'K'
                                       : 'd');
    const auto b = bits(type == "int" || type == "unsignedint" ? 4 : 8);
    if (type == "double") {
      double d;
      std::memcpy(&d, &b, 8);
      if (!std::isfinite(d)) {
        JsonValue j = JsonValue::object();
        j["$float"] = std::isnan(d) ? "NaN" : d > 0 ? "Infinity" : "-Infinity";
        return j;
      }
      std::ostringstream s;
      s.imbue(std::locale::classic());
      s << std::setprecision(17) << d;
      JsonValue j;
      j.kind = JsonValue::Number;
      j.scalar = s.str();
      return j;
    }
    if (type == "unsignedint")
      return JsonValue(int64_t(b));
    if (type == "size_t" && b > 9007199254740991ULL) {
      JsonValue j = JsonValue::object();
      j["$integer"] = std::to_string(b);
      return j;
    }
    int64_t value;
    if (type == "int") {
      uint32_t u = uint32_t(b);
      int32_t i;
      std::memcpy(&i, &u, 4);
      value = i;
    } else
      std::memcpy(&value, &b, 8);
    if (value > 9007199254740991LL || value < -9007199254740991LL) {
      JsonValue j = JsonValue::object();
      j["$integer"] = std::to_string(value);
      return j;
    }
    return JsonValue(value);
  }
  bool utf8(const std::string& s) {
    for (size_t i = 0; i < s.size();) {
      unsigned c = static_cast<unsigned char>(s[i++]);
      if (c < 128)
        continue;
      int n;
      unsigned min;
      if (c >= 194 && c <= 223) {
        n = 1;
        min = 128;
        c &= 31;
      } else if (c >= 224 && c <= 239) {
        n = 2;
        min = 2048;
        c &= 15;
      } else if (c >= 240 && c <= 244) {
        n = 3;
        min = 65536;
        c &= 7;
      } else
        return false;
      while (n--) {
        if (i == s.size())
          return false;
        unsigned b = static_cast<unsigned char>(s[i++]);
        if ((b & 192) != 128)
          return false;
        c = (c << 6) | (b & 63);
      }
      if (c < min || c > 0x10ffff || (c >= 0xd800 && c <= 0xdfff))
        return false;
    }
    return true;
  }
  JsonValue payload(uint64_t offset, uint64_t n, bool defer) {
    if (defer) {
      blobs.push_back({offset, n});
      JsonValue j = JsonValue::object();
      j["kind"] = "deferred_bytes";
      j["offset"] = JsonValue(int64_t(offset));
      j["byteLength"] = JsonValue(int64_t(n));
      j["encoding"] = "casadi-nibbles";
      return j;
    }
    if (n > 1000000)
      fail("Excessive eager byte payload; use lazy mode");
    std::vector<unsigned char> bytes(size_t(n), 0);
    source->read(offset, bytes.data(), bytes.size());
    JsonValue v = JsonValue::array();
    for (auto b : bytes)
      v.a.push_back(JsonValue(int(b)));
    JsonValue j = JsonValue::object();
    j["$bytes"] = v;
    return j;
  }
  JsonValue string() {
    decoration('s');
    auto n = size(number("int")), offset = take(n);
    if (lazy && n >= 65536)
      return payload(offset, n, true);
    std::string text(size_t(n), '\0');
    if (n)
      source->read(offset, reinterpret_cast<unsigned char*>(&text[0]), size_t(n));
    if (utf8(text))
      return JsonValue(text);
    return payload(offset, n, lazy);
  }
  void name(const std::string& n) {
    if (debug) {
      JsonValue j = string();
      if (j.kind != JsonValue::String || j.scalar != n)
        fail("Expected serialized field " + n);
    }
  }
  using Scope = std::map<std::string, JsonValue>;
  void enter_layout() {
    if (++depth > 256)
      fail("Layout nesting limit exceeded");
  }
  template <class Read>
  JsonValue field(JsonValue& record, const std::string& field_name, const std::string& type,
                  Read read) {
    name(field_name);
    JsonValue v = read(), f = JsonValue::object();
    f["name"] = field_name;
    f["type"] = type;
    f["value"] = v;
    record["fields"].a.push_back(std::move(f));
    count(JsonValue(int64_t(record["fields"].a.size())));
    return v;
  }
  void version(JsonValue& record, const std::string& base, int expected) {
    auto v =
        field(record, base + "::serialization::version", "int", [&]() { return number("int"); });
    if (v.n() != expected)
      fail("Unsupported " + base + " version " + v.dump());
  }
#include "generated.hpp"
  JsonValue primitive(const std::string& type) {
    if (type == "int" || type == "unsignedint" || type == "casadi_int" || type == "size_t" ||
        type == "double")
      return number(type);
    if (type == "char")
      return JsonValue(byte());
    if (type == "bool")
      return boolvalue();
    if (type == "std::string")
      return string();
    if (type == "std::istream" || type == "std::stringstream")
      return streamvalue();
    fail("Unknown serialization type: " + type);
  }
  JsonValue boolvalue() {
    decoration('b');
    const int b = byte();
    if (b > 1)
      fail("Invalid boolean");
    return JsonValue::boolean(b != 0);
  }
  JsonValue streamvalue() {
    decoration('B');
    const auto n = size(number("size_t")), offset = take(n);
    return payload(offset, n, lazy);
  }
  JsonValue object(const std::string& type, const std::string& tag, bool shared_object,
                   void (Reader::*read)(JsonValue&, Scope&)) {
    if (!tag.empty())
      decoration(tag[0]);
    if (shared_object) {
      name("Shared::flag");
      int flag = byte();
      if (flag == 'r') {
        name("Shared::reference");
        auto id = number("casadi_int");
        if (id.kind != JsonValue::Number || id.n() < 0 || uint64_t(id.n()) >= shared.size())
          fail("Invalid shared reference");
        JsonValue r = JsonValue::object();
        r["$ref"] = JsonValue(shared[size_t(id.n())]);
        return r;
      }
      if (flag != 'd')
        fail("Invalid shared definition");
    }
    JsonValue record = JsonValue::object();
    record["type"] = type;
    record["fields"] = JsonValue::array();
    record["layouts"] = JsonValue::array();
    std::map<std::string, JsonValue> scope;
    (this->*read)(record, scope);
    if (!shared_object)
      return record;
    count(JsonValue(int64_t(objects.a.size() + 1)));
    int64_t id = objects.a.size();
    objects.a.push_back(std::move(record));
    shared.push_back(id);
    JsonValue r = JsonValue::object();
    r["$ref"] = JsonValue(id);
    return r;
  }
  JsonValue document(const std::string& type) {
    if (number("casadi_int").n() != serialization_magic)
      fail("Invalid serialization magic");
    if (number("casadi_int").n() != serialization_protocol)
      fail("Unsupported serialization protocol");
    int b = byte();
    if (b > 1)
      fail("Invalid debug flag");
    debug = b != 0;
    JsonValue roots = JsonValue::array();
    if (!type.empty())
      roots.a.push_back(value(type));
    else
      while (pos < source->size) {
        const int tag = byte();
        const FileType* entry = file_type(tag);
        if (!entry)
          fail("Unsupported serialized file type " + std::to_string(tag));
        if (*entry->prefix)
          value(entry->prefix);
        roots.a.push_back(value(entry->type));
      }
    if (pos != source->size)
      fail("Trailing serialization data");
    JsonValue d = JsonValue::object();
    d["format"] = "casadi_serialization";
    d["version"] = JsonValue(1);
    d["serializationProtocol"] = JsonValue(serialization_protocol);
    d["root"] = roots.a.size() == 1 ? optional(roots.a[0], "$ref") : JsonValue();
    d["roots"] = roots;
    d["objects"] = objects;
    return d;
  }
};

}  // namespace casadi_reader_detail
