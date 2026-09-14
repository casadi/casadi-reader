#ifndef CASADI_READER_H
#define CASADI_READER_H
#include <stddef.h>
#include <stdint.h>
#if defined(_WIN32)
# if defined(CASADI_READER_BUILD)
#  define CR_API __declspec(dllexport)
# else
#  define CR_API __declspec(dllimport)
# endif
#else
# define CR_API
#endif
#ifdef __cplusplus
extern "C" {
#endif
/* Handles own their sources. JSON and error pointers remain valid until close.
   resource: raw Resource stream instead of Function.save(); lazy: defer blobs.
   An error returns NULL and writes a bounded, NUL-terminated message to error.
   Independent handles may be used concurrently; a handle is not thread-safe. */
typedef struct cr_document cr_document;
CR_API cr_document *cr_open(const char *path, int resource, int lazy,
                           char *error, size_t error_capacity);
CR_API const char *cr_json(const cr_document *document);
CR_API size_t cr_blob_count(const cr_document *document);
CR_API uint64_t cr_blob_size(const cr_document *document, size_t index);
/* Returns 0 on success, -1 on error. No exceptions cross the C ABI. */
CR_API int cr_blob_read(cr_document *document, size_t index, uint64_t offset,
                       void *buffer, size_t length, char *error, size_t error_capacity);
CR_API void cr_close(cr_document *document);
#ifdef __cplusplus
}
#endif
#endif
