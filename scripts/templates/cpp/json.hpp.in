// Generated; edit scripts/templates/cpp/json.hpp.in.
#pragma once
#include <algorithm>
#include <cmath>
#include <cstring>
#include <fstream>
#include <functional>
#include <iomanip>
#include <limits>
#include <locale>
#include <map>
#include <memory>
#include <sstream>
#include <stdexcept>
#include <vector>

namespace casadi_reader_detail {
// Small JSON value used internally. Shared wire objects become indices immediately.
struct JsonValue {
  enum Kind { Null, Bool, Number, String, Array, Object } kind = Null;
  std::string scalar;
  std::vector<JsonValue> a;
  std::map<std::string, JsonValue> o;
  JsonValue() = default;
  JsonValue(int64_t n) : kind(Number), scalar(std::to_string(n)) {}
  JsonValue(int n) : JsonValue(int64_t(n)) {}
  JsonValue(const char* s) : kind(String), scalar(s) {}
  JsonValue(std::string s) : kind(String), scalar(std::move(s)) {}
  static JsonValue boolean(bool b) {
    JsonValue v;
    v.kind = Bool;
    v.scalar = b ? "true" : "false";
    return v;
  }
  static JsonValue array() {
    JsonValue v;
    v.kind = Array;
    return v;
  }
  static JsonValue object() {
    JsonValue v;
    v.kind = Object;
    return v;
  }
  JsonValue& operator[](const std::string& k) {
    return o[k];
  }
  const JsonValue& at(const std::string& k) const {
    return o.at(k);
  }
  int64_t n() const {
    if (kind != Number)
      throw std::runtime_error("Expected number");
    return std::stoll(scalar);
  }
  static std::string quote(const std::string& s) {
    std::ostringstream out;
    out << '"';
    for (unsigned char c : s) {
      if (c == '"' || c == '\\')
        out << '\\' << c;
      else if (c < 32)
        out << "\\u00" << "0123456789abcdef"[c >> 4] << "0123456789abcdef"[c & 15];
      else
        out << c;
    }
    return out.str() + '"';
  }
  std::string dump() const {
    if (kind == Null)
      return "null";
    if (kind == String)
      return quote(scalar);
    if (kind == Number || kind == Bool)
      return scalar;
    std::string s = kind == Array ? "[" : "{";
    bool first = true;
    if (kind == Array)
      for (const auto& v : a) {
        if (!first)
          s += ',';
        first = false;
        s += v.dump();
      }
    else
      for (const auto& v : o) {
        if (!first)
          s += ',';
        first = false;
        s += quote(v.first) + ':' + v.second.dump();
      }
    return s + (kind == Array ? "]" : "}");
  }
};

}  // namespace casadi_reader_detail
