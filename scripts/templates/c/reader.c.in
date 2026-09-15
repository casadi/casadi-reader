/* Generated native C99 reader; edit scripts/templates/c/reader.c.in. */
#include <casadi_reader/reader.h>
#include <ctype.h>
#include <inttypes.h>
#include <locale.h>
#include <math.h>
#include <setjmp.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "metadata.h"
#include "state.h"
#include "json.inc"
#include "source.inc"
#include "runtime.inc"

static void error_text(char* out, size_t cap, const char* text) {
  if (out && cap) {
    snprintf(out, cap, "%s", text);
    out[cap - 1] = 0;
  }
}
void cr_close(cr_document* d) {
  Allocation* a;
  if (!d)
    return;
  if (d->file)
    fclose(d->file);
  a = d->allocations;
  while (a) {
    Allocation* next = a->next;
    free(a);
    a = next;
  }
  free(d);
}
static cr_document* open_document(const char* path, const char* text, size_t length,
                                  const char* type, int lazy, char* error, size_t cap) {
  cr_document* d = (cr_document*)calloc(1, sizeof(cr_document));
  uint64_t end;
  int c;
  if (!d) {
    error_text(error, cap, "Out of memory");
    return NULL;
  }
  if (setjmp(d->jump)) {
    error_text(error, cap, d->error);
    cr_close(d);
    return NULL;
  }
  d->lazy = lazy;
  if (text) {
    d->text = slice(d, text, length);
    end = length;
    while (d->start < end && isspace((unsigned char)d->text[d->start]))
      ++d->start;
    while (end > d->start && isspace((unsigned char)d->text[end - 1]))
      --end;
  } else {
    long n;
    if (!path)
      fail(d, "Null path or text");
    d->file = fopen(path, "rb");
    if (!d->file)
      fail(d, "Cannot open file");
    if (fseek(d->file, 0, SEEK_END) || (n = ftell(d->file)) < 0)
      fail(d, "Cannot size file");
    end = (uint64_t)n;
    while (d->start < end) {
      fseek(d->file, (long)d->start, SEEK_SET);
      c = fgetc(d->file);
      if (!isspace(c))
        break;
      ++d->start;
    }
    while (end > d->start) {
      fseek(d->file, (long)(end - 1), SEEK_SET);
      c = fgetc(d->file);
      if (!isspace(c))
        break;
      --end;
    }
  }
  if ((end - d->start) % 2 || (end - d->start) / 2 > (UINT64_C(1) << 30))
    fail(d, "Invalid encoded file size");
  d->size = (end - d->start) / 2;
  decode_document(d, type);
  error_text(error, cap, "");
  return d;
}
cr_document* cr_open_type(const char* path, const char* type, int lazy, char* error, size_t cap) {
  return open_document(path, NULL, 0, type, lazy, error, cap);
}
cr_document* cr_open(const char* path, int resource, int lazy, char* error, size_t cap) {
  return cr_open_type(path, resource ? "Resource" : NULL, lazy, error, cap);
}
cr_document* cr_decode(const char* text, size_t length, const char* type, int lazy, char* error,
                       size_t cap) {
  return open_document(NULL, text, length, type, lazy, error, cap);
}
const char* cr_json(const cr_document* d) {
  return d ? d->json : NULL;
}
size_t cr_blob_count(const cr_document* d) {
  return d ? d->blob_count : 0;
}
static Blob* get_blob(const cr_document* d, size_t i) {
  Blob* b = d ? d->blobs : NULL;
  while (i-- && b)
    b = b->next;
  return b;
}
uint64_t cr_blob_size(const cr_document* d, size_t i) {
  Blob* b = get_blob(d, i);
  return b ? b->size : 0;
}
int cr_blob_read(cr_document* d, size_t i, uint64_t offset, void* buffer, size_t length,
                 char* error, size_t cap) {
  Blob* b = get_blob(d, i);
  if (!b || (!buffer && length)) {
    error_text(error, cap, "Invalid document, blob or buffer");
    return -1;
  }
  if (setjmp(d->jump)) {
    error_text(error, cap, d->error);
    return -1;
  }
  if (offset > b->size || length > b->size - offset)
    fail(d, "Blob range out of bounds");
  source_read(d, b->offset + offset, (unsigned char*)buffer, length);
  error_text(error, cap, "");
  return 0;
}
