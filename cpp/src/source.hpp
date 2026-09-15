// Generated; edit scripts/templates/cpp/source.hpp.in.
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
struct EncodedSource {
  std::ifstream file;
  std::string text;
  bool memory = false;
  uint64_t start = 0, size = 0;
  explicit EncodedSource(const char* path) : file(path, std::ios::binary) {
    if (!file)
      throw std::runtime_error("Cannot open file");
    file.seekg(0, std::ios::end);
    auto end = file.tellg();
    if (end < 0)
      throw std::runtime_error("Cannot size file");
    uint64_t n = uint64_t(end);
    auto whitespace = [](char c) { return c == ' ' || c == '\t' || c == '\r' || c == '\n'; };
    char c;
    while (start < n) {
      file.seekg(start);
      file.get(c);
      if (!whitespace(c))
        break;
      ++start;
    }
    while (n > start) {
      file.seekg(n - 1);
      file.get(c);
      if (!whitespace(c))
        break;
      --n;
    }
    if ((n - start) % 2 || (n - start) / 2 > uint64_t(1) << 30)
      throw std::runtime_error("Invalid encoded file size");
    size = (n - start) / 2;
  }
  EncodedSource(const char* data, size_t length) : text(data, length), memory(true) {
    uint64_t end = length;
    while (start < end && std::isspace(static_cast<unsigned char>(text[start])))
      ++start;
    while (end > start && std::isspace(static_cast<unsigned char>(text[end - 1])))
      --end;
    if ((end - start) % 2 || (end - start) / 2 > (uint64_t(1) << 30))
      throw std::runtime_error("Invalid encoded file size");
    size = (end - start) / 2;
  }
  void read(uint64_t offset, unsigned char* output, size_t n) {
    if (offset > size || n > size - offset)
      throw std::runtime_error("Source range out of bounds");
    if (!memory) {
      file.clear();
      file.seekg(start + 2 * offset);
    }
    for (size_t i = 0; i < n; ++i) {
      char a, b;
      if (memory) {
        a = text[start + 2 * (offset + i)];
        b = text[start + 2 * (offset + i) + 1];
      } else if (!file.get(a) || !file.get(b))
        throw std::runtime_error("Truncated file");
      if (a < 'a' || a > 'p' || b < 'a' || b > 'p')
        throw std::runtime_error("Invalid nibble encoding");
      output[i] = (a - 'a') | ((b - 'a') << 4);
    }
  }
};
struct ByteRange {
  uint64_t offset, size;
};

}  // namespace casadi_reader_detail
