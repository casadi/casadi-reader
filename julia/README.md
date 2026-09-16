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

## Tests and coverage

`Pkg.test()` uses the fixture corpus shipped in `test/fixtures`; Python, CasADi,
compilers, solver installations, and `CASADI_READER_FIXTURES` are not needed.
The manifest names each native `.casadi` file and its structural JSON reference.
Plain/debug pairs share references when their decoded documents are identical.
Two known upstream ConstantFile/ConstantPool debug-format mismatches are tested
as explicit rejections. Other unexpected decoding failures fail generation.

The corpus covers MX/SX operators, indexing and sparse matrices, generic values,
interpolation, differentiation, mapping, integrators, rootfinders, public solvers,
FMI 2/3 models, external functions, and JIT serialization. Wire-level tests cover
invalid input, limits, numeric edge cases, and corrupt discriminators.

From the repository root on the `generate` branch, regenerate with Linux, a C
compiler, and Python 3.9–3.12 (CI uses 3.11; prefer a virtual environment):

```sh
python -m pip install -r scripts/requirements-fixtures.txt
python scripts/generate-reader-assets.py
python scripts/generate-julia-fixtures.py
python scripts/julia-coverage.py --clean
julia --project=julia -e 'using Pkg; Pkg.test(coverage=true)'
python scripts/julia-coverage.py --minimum 90 --runtime-minimum 100
```

Generation pins CasADi to the schema version. Tiny native models are built in a
temporary directory; the FMU and external libraries are not shipped. The JIT
embed case intentionally includes a small binary payload, decoded as opaque
bytes on every platform. FMU tokens and JIT library paths are normalized for
reproducibility. Native round-trip limitations are recorded in `manifest.json`.
The uncompressed corpus has a 10 MiB budget; the standalone ZIP is much smaller.

CI generates the corpus once, tests that exact artifact on every Julia platform,
and includes it in the generated `main` commit and release ZIP. Coverage is
uploaded to Codecov and attached as a `julia-coverage` Actions artifact containing
LCOV, a JSON summary, and an uncovered-line report. CI requires 100% measured
runtime line coverage and at least 90% overall line coverage. Generated decoder
code and unavailable plugins remain in the denominator.

100% overall coverage is not claimed. Remaining gaps include licensed solvers,
plugins absent from the pip wheel (such as Clarabel, HPMPC, OOQP, and MadNLP),
less common embedded-resource modes, and unreachable dispatch guards (for
example an unknown boolean discriminator after strict boolean validation).
Some SX node kinds are simplified away by CasADi's public constructors. Consult
`coverage/julia.uncovered.txt` for the exact lines; no coverage exclusions are
used to hide these gaps. Line coverage does not imply complete branch coverage.
