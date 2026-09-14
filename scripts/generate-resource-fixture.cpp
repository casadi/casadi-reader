// Build against CasADi with filesystem and libzip plugins, then pass a ZIP and output path.
#include <casadi/core/resource.hpp>
#include <casadi/core/serializing_stream.hpp>
#include <fstream>
int main(int argc, char** argv) {
  if (argc != 3) return 2;
  casadi::Resource resource(argv[1]);
  resource.change_option("serialize_mode", "embed");
  std::ofstream output(argv[2]);
  casadi::SerializingStream stream(output);
  stream.pack(resource);
}
