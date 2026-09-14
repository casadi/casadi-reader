#ifndef CASADI_READER_HPP
#define CASADI_READER_HPP
#include "reader.h"
#include <memory>
#include <stdexcept>
#include <string>
#include <vector>
namespace casadi_reader {
class Document {
  std::unique_ptr<cr_document, decltype(&cr_close)> handle_;
 public:
  explicit Document(const std::string& path, bool resource=false, bool lazy=false)
      : handle_(nullptr, cr_close) {
    char error[1024];
    handle_.reset(cr_open(path.c_str(), resource, lazy, error, sizeof(error)));
    if (!handle_) throw std::runtime_error(error);
  }
  std::string json() const { return cr_json(handle_.get()); }
  size_t blob_count() const { return cr_blob_count(handle_.get()); }
  uint64_t blob_size(size_t index) const {
    if (index >= blob_count()) throw std::out_of_range("Blob index");
    return cr_blob_size(handle_.get(), index);
  }
  std::vector<unsigned char> read_blob(size_t index, uint64_t offset, size_t length) {
    if (index >= blob_count() || offset > blob_size(index) || length > blob_size(index)-offset)
      throw std::out_of_range("Blob range");
    std::vector<unsigned char> result(length);
    char error[1024];
    if (cr_blob_read(handle_.get(), index, offset, result.data(), length, error, sizeof(error)))
      throw std::runtime_error(error);
    return result;
  }
};
}
#endif
