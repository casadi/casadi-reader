/* Encoded input, primitive decoding, and lazy byte ranges. */
static uint64_t take(cr_document* d, uint64_t n) {
  uint64_t start = d->pos;
  if (n > d->size - d->pos)
    fail(d, "Truncated or excessive payload");
  d->pos += n;
  return start;
}
static void source_read(cr_document* d, uint64_t offset, unsigned char* out, size_t n) {
  size_t i;
  if (offset > d->size || n > d->size - offset)
    fail(d, "Source range out of bounds");
  if (d->file && fseek(d->file, (long)(d->start + 2 * offset), SEEK_SET))
    fail(d, "Cannot seek source");
  for (i = 0; i < n; ++i) {
    int a, b;
    if (d->text) {
      a = (unsigned char)d->text[d->start + 2 * (offset + i)];
      b = (unsigned char)d->text[d->start + 2 * (offset + i) + 1];
    } else {
      a = fgetc(d->file);
      b = fgetc(d->file);
    }
    if (a < 'a' || a > 'p' || b < 'a' || b > 'p')
      fail(d, "Invalid .casadi encoding");
    out[i] = (unsigned char)((a - 'a') | ((b - 'a') << 4));
  }
}
static uint64_t bits(cr_document* d, int n) {
  unsigned char bytes[8];
  uint64_t v = 0;
  int i;
  source_read(d, take(d, (uint64_t)n), bytes, (size_t)n);
  for (i = 0; i < n; ++i)
    v |= (uint64_t)bytes[i] << (8 * i);
  return v;
}
static int byte(cr_document* d) {
  return (int)bits(d, 1);
}
static void decoration(cr_document* d, char tag) {
  if (d->debug && byte(d) != tag)
    fail(d, "Expected wire decoration %c", tag);
}
static J* number(cr_document* d, const char* type) {
  uint64_t b;
  int64_t i;
  char out[64];
  decoration(d, !strcmp(type, "int")           ? 'i'
                : !strcmp(type, "unsignedint") ? 'u'
                : !strcmp(type, "casadi_int")  ? 'J'
                : !strcmp(type, "size_t")      ? 'K'
                                               : 'd');
  b = bits(d, (!strcmp(type, "int") || !strcmp(type, "unsignedint")) ? 4 : 8);
  if (!strcmp(type, "double")) {
    double f;
    char* decimal;
    memcpy(&f, &b, 8);
    if (!isfinite(f))
      return wrapped(d, "$float", str(d, isnan(f) ? "NaN" : f > 0 ? "Infinity" : "-Infinity"));
    snprintf(out, sizeof(out), "%.17g", f);
    decimal = strstr(out, localeconv()->decimal_point);
    if (decimal && strlen(localeconv()->decimal_point) == 1)
      *decimal = '.';
    return scalar(d, NUMBER, out);
  }
  if (!strcmp(type, "unsignedint"))
    return integer(d, (int64_t)b);
  if (!strcmp(type, "size_t") && b > UINT64_C(9007199254740991)) {
    snprintf(out, sizeof(out), "%" PRIu64, b);
    return wrapped(d, "$integer", str(d, out));
  }
  if (!strcmp(type, "int")) {
    uint32_t u = (uint32_t)b;
    int32_t x;
    memcpy(&x, &u, 4);
    i = x;
  } else
    memcpy(&i, &b, 8);
  if (i > INT64_C(9007199254740991) || i < -INT64_C(9007199254740991)) {
    snprintf(out, sizeof(out), "%" PRId64, i);
    return wrapped(d, "$integer", str(d, out));
  }
  return integer(d, i);
}
static uint64_t sizevalue(cr_document* d, J* v, uint64_t max) {
  char* end;
  uint64_t n;
  if (!v || v->kind != NUMBER || v->s[0] == '-')
    fail(d, "Invalid size");
  n = strtoull(v->s, &end, 10);
  if (*end || n > max)
    fail(d, "Invalid or excessive collection size");
  return n;
}
static int utf8(const unsigned char* s, size_t len) {
  size_t i = 0;
  while (i < len) {
    unsigned c = s[i++], min;
    int n;
    if (c < 128)
      continue;
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
      return 0;
    while (n--) {
      unsigned b;
      if (i == len)
        return 0;
      b = s[i++];
      if ((b & 192) != 128)
        return 0;
      c = (c << 6) | (b & 63);
    }
    if (c < min || c > 0x10ffff || (c >= 0xd800 && c <= 0xdfff))
      return 0;
  }
  return 1;
}
static J* payload(cr_document* d, uint64_t offset, uint64_t n, int lazy) {
  J* v = node(d, OBJECT);
  if (lazy) {
    Blob* b = (Blob*)allocate(d, sizeof(Blob));
    b->offset = offset;
    b->size = n;
    if (d->last_blob)
      d->last_blob->next = b;
    else
      d->blobs = b;
    d->last_blob = b;
    ++d->blob_count;
    set(d, v, "kind", str(d, "deferred_bytes"));
    set(d, v, "offset", integer(d, (int64_t)offset));
    set(d, v, "byteLength", integer(d, (int64_t)n));
    set(d, v, "encoding", str(d, "casadi-nibbles"));
  } else {
    unsigned char* bytes;
    uint64_t i;
    J* a = node(d, ARRAY);
    if (n > 1000000)
      fail(d, "Excessive eager payload; use lazy mode");
    bytes = (unsigned char*)allocate(d, (size_t)n);
    source_read(d, offset, bytes, (size_t)n);
    for (i = 0; i < n; ++i)
      push(d, a, integer(d, bytes[i]));
    set(d, v, "$bytes", a);
  }
  return v;
}
static J* stringvalue(cr_document* d) {
  uint64_t n, offset;
  unsigned char* bytes;
  decoration(d, 's');
  n = sizevalue(d, number(d, "int"), d->size);
  offset = take(d, n);
  if (d->lazy && n >= 65536)
    return payload(d, offset, n, 1);
  bytes = (unsigned char*)allocate(d, (size_t)n);
  source_read(d, offset, bytes, (size_t)n);
  if (utf8(bytes, (size_t)n))
    return strn(d, (const char*)bytes, (size_t)n);
  return payload(d, offset, n, d->lazy);
}
static void fieldname(cr_document* d, const char* name) {
  if (d->debug) {
    J* v = stringvalue(d);
    if (v->kind != STRING || strcmp(v->s, name))
      fail(d, "Expected serialized field %s", name);
  }
}
static char* trim(cr_document* d, const char* s) {
  size_t n;
  while (isspace((unsigned char)*s))
    ++s;
  n = strlen(s);
  while (n && isspace((unsigned char)s[n - 1]))
    --n;
  return slice(d, s, n);
}
