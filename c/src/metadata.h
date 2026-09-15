/* Generated wire constants and file framing tags. */
#include <stdint.h>
#include <stddef.h>
static const int64_t serialization_magic = 123456789012345;
static const int64_t serialization_protocol = 3;
typedef struct { int tag; const char* type; const char* prefix; } FileType;
static const FileType file_types[] = {
    {0, "Sparsity", ""},
    {1, "MX", "Function"},
    {10, "std::vector<Sparsity>", ""},
    {11, "std::vector<MX>", "Function"},
    {12, "std::vector<DM>", ""},
    {13, "std::vector<SX>", "Function"},
    {15, "std::vector<Function>", ""},
    {16, "std::vector<GenericType>", ""},
    {17, "std::vector<casadi_int>", ""},
    {18, "std::vector<double>", ""},
    {19, "std::vector<std::string>", ""},
    {2, "DM", ""},
    {20, "MX", "std::vector<MX>"},
    {21, "SX", "std::vector<SX>"},
    {22, "std::vector<MX>", "std::vector<MX>"},
    {23, "std::vector<SX>", "std::vector<SX>"},
    {3, "SX", "Function"},
    {4, "Linsol", ""},
    {5, "Function", ""},
    {6, "GenericType", ""},
    {7, "casadi_int", ""},
    {8, "double", ""},
    {9, "std::string", ""},
};
static const FileType* file_type(int tag) {
    for (size_t i = 0; i < sizeof(file_types) / sizeof(file_types[0]); ++i) {
        if (file_types[i].tag == tag) return &file_types[i];
    }
    return NULL;
}
