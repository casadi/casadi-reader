/* Shared binary reading and record construction. */
static J* primitive(cr_document* d, const char* type);
static J* object(cr_document* d, const char* type, const char* tag, int shared,
                 void (*read)(cr_document*, J*, J*));
static void enter_layout(cr_document* d) {
  if (++d->depth > 256)
    fail(d, "Layout nesting limit exceeded");
}
static J* scope_value(cr_document* d, J* scope, const char* name) {
  J* result = get(scope, name);
  if (!result)
    fail(d, "Missing serialized field or parameter: %s", name);
  return result;
}
static J* concat(cr_document* d, const char* a, const char* b) {
  Buffer out = {d, NULL, 0, 0};
  writebuf(&out, a, strlen(a));
  writebuf(&out, b, strlen(b));
  return str(d, out.s);
}
static J* field(cr_document* d, J* record, const char* name, const char* type,
                J* (*read)(cr_document*)) {
  fieldname(d, name);
  J* v = read(d);
  J* f = node(d, OBJECT);
  set(d, f, "name", str(d, name));
  set(d, f, "type", str(d, type));
  set(d, f, "value", v);
  push(d, get(record, "fields"), f);
  if (get(record, "fields")->count > 1000000)
    fail(d, "Excessive fields");
  return v;
}
static J* read_version_int(cr_document* d) {
  return number(d, "int");
}
static void version(cr_document* d, J* record, const char* base, int expected) {
  J* name = concat(d, base, "::serialization::version");
  J* v = field(d, record, text(name), "int", read_version_int);
  if (!equal(v, integer(d, expected)))
    fail(d, "Unsupported serialization version: %s", base);
}
static J* boolvalue(cr_document* d) {
  decoration(d, 'b');
  const int b = byte(d);
  if (b > 1)
    fail(d, "Invalid boolean");
  return boolean(d, b);
}
static J* streamvalue(cr_document* d) {
  decoration(d, 'B');
  const uint64_t n = sizevalue(d, number(d, "size_t"), d->size);
  const uint64_t offset = take(d, n);
  return payload(d, offset, n, d->lazy);
}
#include "generated.inc"
static J* primitive(cr_document* d, const char* raw) {
  const char* type = raw;
  if (!strcmp(type, "int") || !strcmp(type, "unsignedint") || !strcmp(type, "casadi_int") ||
      !strcmp(type, "size_t") || !strcmp(type, "double"))
    return number(d, type);
  if (!strcmp(type, "char"))
    return integer(d, byte(d));
  if (!strcmp(type, "bool"))
    return boolvalue(d);
  if (!strcmp(type, "std::string"))
    return stringvalue(d);
  if (!strcmp(type, "std::istream") || !strcmp(type, "std::stringstream"))
    return streamvalue(d);
  fail(d, "Unknown serialization type: %s", type);
  return NULL;
}
static J* object(cr_document* d, const char* type, const char* decoration_tag, int shared,
                 void (*read)(cr_document*, J*, J*)) {
  J *record, *tag;
  if (*decoration_tag)
    decoration(d, decoration_tag[0]);
  if (shared) {
    int flag;
    fieldname(d, "Shared::flag");
    flag = byte(d);
    if (flag == 'r') {
      uint64_t i;
      fieldname(d, "Shared::reference");
      i = sizevalue(d, number(d, "casadi_int"), d->shared->count);
      if (i >= d->shared->count)
        fail(d, "Invalid shared reference");
      return wrapped(d, "$ref", at(d->shared, (size_t)i));
    }
    if (flag != 'd')
      fail(d, "Invalid shared definition");
  }
  record = node(d, OBJECT);
  set(d, record, "type", str(d, type));
  set(d, record, "fields", node(d, ARRAY));
  set(d, record, "layouts", node(d, ARRAY));
  read(d, record, node(d, OBJECT));
  if (!shared)
    return record;
  if (d->objects->count >= 1000000)
    fail(d, "Excessive objects");
  tag = integer(d, (int64_t)d->objects->count);
  push(d, d->objects, record);
  push(d, d->shared, tag);
  return wrapped(d, "$ref", tag);
}
static void decode_document(cr_document* d, const char* type) {
  J *roots = node(d, ARRAY), *doc = node(d, OBJECT);
  Buffer b = {d, NULL, 0, 0};
  int flag;
  d->objects = node(d, ARRAY);
  d->shared = node(d, ARRAY);
  if (!equal(number(d, "casadi_int"), integer(d, serialization_magic)))
    fail(d, "Invalid serialization magic");
  if (!equal(number(d, "casadi_int"), integer(d, serialization_protocol)))
    fail(d, "Unsupported serialization protocol");
  flag = byte(d);
  if (flag > 1)
    fail(d, "Invalid debug flag");
  d->debug = flag;
  if (type && *type)
    push(d, roots, value(d, type));
  else
    while (d->pos < d->size) {
      int tag = byte(d);
      const FileType* entry = file_type(tag);
      if (!entry)
        fail(d, "Unsupported serialized file type %d", tag);
      if (*entry->prefix)
        value(d, entry->prefix);
      push(d, roots, value(d, entry->type));
    }
  if (d->pos != d->size)
    fail(d, "Trailing serialization data");
  set(d, doc, "format", str(d, "casadi_serialization"));
  set(d, doc, "version", integer(d, 1));
  set(d, doc, "serializationProtocol", integer(d, serialization_protocol));
  set(d, doc, "root", roots->count == 1 ? get(at(roots, 0), "$ref") : NULL);
  set(d, doc, "roots", roots);
  set(d, doc, "objects", d->objects);
  dump(&b, doc);
  d->json = b.s;
}
