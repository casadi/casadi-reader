# CasADiReader

Read `.casadi` files into typed fields and shared references, without loading
CasADi or evaluating functions. Supports ordinary and debug serialization,
including MX, SX, nested Function calls, ONNX configuration and opaque bytes.

```julia
using CasADiReader
record = read_casadi("function.casadi")
# For serialized text already in memory:
record = parse_casadi(read("function.casadi", String))
```

For a standalone download, extract `casadi-reader-julia.zip`, then add its path:

```julia
push!(LOAD_PATH, "/path/to/casadi-reader-julia")
using CasADiReader
```

Only Julia's standard library is required. `read_resource(path; lazy=true)`
returns a `Document` whose opaque payloads can be read with `read_blob`.
Use `casadi_data(document)` for structural data, `casadi_json(document)` for JSON, and
`close(document)` when finished with its file mapping.

The source generator lives on the repository's `generate` branch. `main`
contains the emitted readers. The generator and runtime templates were developed
with Codex assistance; emitted readers are generated deterministically from
CasADi's serialization scheme. Tests compare ordinary/debug fixtures and
regenerated readers across all six supported languages.
