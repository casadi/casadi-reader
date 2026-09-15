// Generated; edit scripts/templates/cpp/reader.cpp.in.
#include <casadi_reader/reader.h>

#include "runtime.hpp"
using namespace casadi_reader_detail;
namespace casadi_reader_detail {
void error_text(char* buffer, size_t capacity, const char* message) noexcept {
  if (buffer && capacity) {
    std::strncpy(buffer, message, capacity - 1);
    buffer[capacity - 1] = 0;
  }
}
}  // namespace casadi_reader_detail
struct cr_document {
  std::shared_ptr<EncodedSource> source;
  std::vector<ByteRange> blobs;
  std::string json;
};
extern "C" {
cr_document* cr_open_type(const char* path, const char* type, int lazy, char* error, size_t cap) {
  try {
    if (!path)
      throw std::invalid_argument("Null path");
    auto d = std::unique_ptr<cr_document>(new cr_document);
    d->source = std::make_shared<EncodedSource>(path);
    Reader r(d->source, lazy != 0);
    d->json = r.document(type ? type : "").dump();
    d->blobs = std::move(r.blobs);
    error_text(error, cap, "");
    return d.release();
  } catch (const std::exception& e) {
    error_text(error, cap, e.what());
  } catch (...) {
    error_text(error, cap, "Unknown reader error");
  }
  return nullptr;
}
cr_document* cr_open(const char* path, int resource, int lazy, char* error, size_t cap) {
  return cr_open_type(path, resource ? "Resource" : nullptr, lazy, error, cap);
}
cr_document* cr_decode(const char* text, size_t length, const char* type, int lazy, char* error,
                       size_t cap) {
  try {
    if (!text)
      throw std::invalid_argument("Null text");
    auto d = std::unique_ptr<cr_document>(new cr_document);
    d->source = std::make_shared<EncodedSource>(text, length);
    Reader r(d->source, lazy != 0);
    d->json = r.document(type ? type : "").dump();
    d->blobs = std::move(r.blobs);
    error_text(error, cap, "");
    return d.release();
  } catch (const std::exception& e) {
    error_text(error, cap, e.what());
  } catch (...) {
    error_text(error, cap, "Unknown reader error");
  }
  return nullptr;
}
const char* cr_json(const cr_document* d) {
  return d ? d->json.c_str() : nullptr;
}
size_t cr_blob_count(const cr_document* d) {
  return d ? d->blobs.size() : 0;
}
uint64_t cr_blob_size(const cr_document* d, size_t i) {
  return d && i < d->blobs.size() ? d->blobs[i].size : 0;
}
int cr_blob_read(cr_document* d, size_t i, uint64_t offset, void* buffer, size_t length,
                 char* error, size_t cap) {
  try {
    if (!d || i >= d->blobs.size() || (!buffer && length))
      throw std::invalid_argument("Invalid document, blob or buffer");
    auto b = d->blobs[i];
    if (offset > b.size || length > b.size - offset)
      throw std::out_of_range("Blob range out of bounds");
    d->source->read(b.offset + offset, static_cast<unsigned char*>(buffer), length);
    error_text(error, cap, "");
    return 0;
  } catch (const std::exception& e) {
    error_text(error, cap, e.what());
  } catch (...) {
    error_text(error, cap, "Unknown reader error");
  }
  return -1;
}
void cr_close(cr_document* d) {
  delete d;
}
}
