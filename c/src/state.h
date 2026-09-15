/* Private state owned by a single reader document. */
typedef struct allocation {
  struct allocation* next;
} Allocation;
typedef struct json J;
typedef struct entry {
  const char* key;
  J* value;
  struct entry* next;
} Entry;
struct json {
  int kind;
  const char* s;
  size_t length, count;
  Entry *first, *last;
};
enum { NIL, BOOL, NUMBER, STRING, ARRAY, OBJECT };
typedef struct blob {
  uint64_t offset, size;
  struct blob* next;
} Blob;
struct cr_document {
  Allocation* allocations;
  FILE* file;
  const char* text;
  uint64_t start, size, pos;
  int lazy, debug, depth;
  jmp_buf jump;
  char error[512];
  J *objects, *shared;
  Blob *blobs, *last_blob;
  size_t blob_count;
  const char* json;
};
