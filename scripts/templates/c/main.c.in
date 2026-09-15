#include <casadi_reader/reader.h>
#include <stdio.h>
#include <string.h>
int main(int argc, char** argv) {
  const char *path = NULL, *type = NULL;
  int lazy = 0, i;
  char error[512];
  cr_document* d;
  for (i = 1; i < argc; ++i) {
    if (!strcmp(argv[i], "--lazy"))
      lazy = 1;
    else if (!strcmp(argv[i], "--resource"))
      type = "Resource";
    else if (!strcmp(argv[i], "--type") && i + 1 < argc)
      type = argv[++i];
    else if (!path)
      path = argv[i];
    else {
      fputs("Unexpected argument\n", stderr);
      return 1;
    }
  }
  if (!path) {
    fputs("Usage: casadi-reader-c [--resource | --type TYPE] [--lazy] FILE\n", stderr);
    return 1;
  }
  d = cr_open_type(path, type, lazy, error, sizeof(error));
  if (!d) {
    fprintf(stderr, "%s\n", error);
    return 1;
  }
  puts(cr_json(d));
  cr_close(d);
  return 0;
}
