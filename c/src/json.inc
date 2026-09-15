/* Arena allocation and JSON values for the generated scheme and decoded records. */
static void fail(cr_document* d, const char* format, ...) {
  va_list args;
  int n = snprintf(d->error, sizeof(d->error), ".casadi byte %" PRIu64 ": ", d->pos);
  va_start(args, format);
  vsnprintf(d->error + n, sizeof(d->error) - (size_t)n, format, args);
  va_end(args);
  longjmp(d->jump, 1);
}
static void* allocate(cr_document* d, size_t size) {
  Allocation* a;
  if (size > SIZE_MAX - sizeof(*a))
    fail(d, "Excessive allocation");
  a = (Allocation*)calloc(1, sizeof(*a) + size);
  if (!a)
    fail(d, "Out of memory");
  a->next = d->allocations;
  d->allocations = a;
  return a + 1;
}
static char* slice(cr_document* d, const char* s, size_t n) {
  char* p = (char*)allocate(d, n + 1);
  memcpy(p, s, n);
  return p;
}
static J* node(cr_document* d, int kind) {
  J* v = (J*)allocate(d, sizeof(J));
  v->kind = kind;
  return v;
}
static J* strn(cr_document* d, const char* s, size_t n) {
  J* v = node(d, STRING);
  v->s = slice(d, s, n);
  v->length = n;
  return v;
}
static J* str(cr_document* d, const char* s) {
  return strn(d, s, strlen(s));
}
static J* scalar(cr_document* d, int kind, const char* s) {
  J* v = str(d, s);
  v->kind = kind;
  return v;
}
static J* integer(cr_document* d, int64_t n) {
  char s[32];
  snprintf(s, sizeof(s), "%" PRId64, n);
  return scalar(d, NUMBER, s);
}
static J* boolean(cr_document* d, int b) {
  return scalar(d, BOOL, b ? "true" : "false");
}
static void append(cr_document* d, J* v, const char* key, J* child) {
  Entry* e = (Entry*)allocate(d, sizeof(Entry));
  e->key = key;
  e->value = child;
  if (v->last)
    v->last->next = e;
  else
    v->first = e;
  v->last = e;
  ++v->count;
}
static J* get(J* v, const char* key) {
  Entry* e;
  if (!v || v->kind != OBJECT)
    return NULL;
  for (e = v->first; e; e = e->next)
    if (!strcmp(e->key, key))
      return e->value;
  return NULL;
}
static void set(cr_document* d, J* v, const char* key, J* child) {
  Entry* e;
  for (e = v->first; e; e = e->next)
    if (!strcmp(e->key, key)) {
      e->value = child;
      return;
    }
  append(d, v, slice(d, key, strlen(key)), child);
}
static void push(cr_document* d, J* v, J* child) {
  append(d, v, NULL, child);
}
static J* at(J* v, size_t i) {
  Entry* e = v->first;
  while (i-- && e)
    e = e->next;
  return e ? e->value : NULL;
}
static const char* text(J* v) {
  return v && v->s ? v->s : "";
}
static int truth(J* v) {
  return v && v->kind != NIL && (v->kind != BOOL || !strcmp(v->s, "true")) &&
         (v->kind != NUMBER || strcmp(v->s, "0")) && (v->kind != STRING || v->length);
}
static J* wrapped(cr_document* d, const char* key, J* v) {
  J* o = node(d, OBJECT);
  set(d, o, key, v);
  return o;
}
typedef struct buffer {
  cr_document* d;
  char* s;
  size_t n, cap;
} Buffer;
static void writebuf(Buffer* b, const char* s, size_t n) {
  if (n > SIZE_MAX - b->n - 1)
    fail(b->d, "Excessive JSON output");
  if (b->n + n + 1 > b->cap) {
    size_t cap = b->cap ? b->cap : 128;
    char* p;
    while (cap < b->n + n + 1) {
      if (cap > SIZE_MAX / 2)
        fail(b->d, "Excessive JSON output");
      cap *= 2;
    }
    p = (char*)allocate(b->d, cap);
    if (b->n)
      memcpy(p, b->s, b->n);
    b->s = p;
    b->cap = cap;
  }
  memcpy(b->s + b->n, s, n);
  b->n += n;
  b->s[b->n] = 0;
}
static void put(Buffer* b, char c) {
  writebuf(b, &c, 1);
}
static void quote(Buffer* b, const char* s, size_t n) {
  size_t i;
  put(b, '"');
  for (i = 0; i < n; ++i) {
    unsigned char c = (unsigned char)s[i];
    if (c == '"' || c == '\\') {
      put(b, '\\');
      put(b, (char)c);
    } else if (c < 32) {
      char e[7];
      snprintf(e, sizeof(e), "\\u%04x", c);
      writebuf(b, e, 6);
    } else
      put(b, (char)c);
  }
  put(b, '"');
}
static void dump(Buffer* b, J* v) {
  Entry* e;
  int first = 1;
  if (!v || v->kind == NIL) {
    writebuf(b, "null", 4);
    return;
  }
  if (v->kind == STRING) {
    quote(b, v->s, v->length);
    return;
  }
  if (v->kind == BOOL || v->kind == NUMBER) {
    writebuf(b, v->s, v->length);
    return;
  }
  put(b, v->kind == ARRAY ? '[' : '{');
  for (e = v->first; e; e = e->next) {
    if (!first)
      put(b, ',');
    first = 0;
    if (v->kind == OBJECT) {
      quote(b, e->key, strlen(e->key));
      put(b, ':');
    }
    dump(b, e->value);
  }
  put(b, v->kind == ARRAY ? ']' : '}');
}
static int equal(J* a, J* b) {
  Entry *x, *y;
  if (!a || !b)
    return a == b;
  if (a->kind != b->kind || a->count != b->count)
    return 0;
  if (a->s || b->s)
    return a->length == b->length && !memcmp(text(a), text(b), a->length);
  for (x = a->first, y = b->first; x; x = x->next, y = y->next)
    if ((x->key && strcmp(x->key, y->key)) || !equal(x->value, y->value))
      return 0;
  return 1;
}
/* JSON parsing is only for the generated scheme and its string expressions. */
