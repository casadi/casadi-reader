# casadi-reader

Inspect `.casadi` files without installing or loading CasADi. One repository
provides JavaScript/npm, Python/PyPI, C++, C, MATLAB and Julia interfaces.
This is a **local proof of concept**, not yet a published release.
Files are inspected, never evaluated; no archives are extracted.

| Interface | Implementation | Runtime dependencies |
| --- | --- | --- |
| `@casadi/casadi-reader` (npm) | Standalone JavaScript | None; Node 22+ or browser ESM |
| `casadi-reader` (PyPI) | Standalone Python | None; Python 3.9+ |
| C++ | Native reader, RAII `Document` | C++ standard library |
| C | C ABI over the native reader | Same native library |
| MATLAB | MATLAB package and MEX | Native reader compiled into the MEX |
| Julia `CasadiReader` | Julia package calling the C ABI | Standalone native library, JSON.jl |

All interfaces use the same object-table JSON contract and fixtures. The three
reader implementations use source assets generated from the vendored scheme.
MATLAB and Julia do not launch Python, Node or a subprocess to decode files.

## Python

Install locally with `pip install .` (the distribution declares no runtime
requirements):

```python
from casadi_reader import read_casadi, read_resource, to_json

graph = read_casadi('model.casadi')
print(to_json(graph, indent=2))

resource = read_resource('resource.casadi', lazy=True)
blob = resource['resource']['blob']
try:
    first_bytes = blob.read(0, 64)
finally:
    blob.close()
```

File input uses a read-only memory map. Lazy payloads keep that mapping alive;
metadata and requested slices are decoded, without allocating the whole archive.
`loads(text)` and `loads_resource(text, lazy=True)` also accept encoded strings.
The CLI is `casadi-reader [--resource] [--lazy] input.casadi [output.json]`, or
`python -m casadi_reader ...`.

## JavaScript

Install locally with `npm install /path/to/casadi-reader`:

```js
import {readCasadi, decodeResource, openResource} from '@casadi/casadi-reader';
const graph = readCasadi(await file.text());
const {resource} = decodeResource(resourceStreamText, {lazy: true});
const firstBytes = resource.blob.read(0, 64); // Uint8Array

// File/Blob input also defers reading the encoded payload:
const opened = await openResource(resourceFile, {lazy: true});
const bytes = await opened.resource.blob.read(0, 64);
```

The npm tarball contains bundled ESM in `dist/`, with serialization metadata
compiled into the JavaScript. It does not fetch or import the scheme JSON.
After publication, a browser can import the versioned
`https://unpkg.com/@casadi/casadi-reader@VERSION/dist/index.js` directly from a
`<script type="module">`; no import map or bundler is required. `VERSION` is a
placeholder: this prototype has not been published.

The Node CLI is `node bin/casadi-reader.js [--resource] [--lazy] input.casadi`.
Text mode retains the encoded string. File/Blob mode reads a bounded metadata
prefix, then requested slices. File/Blob Resource input must have no surrounding
whitespace. An application installing both CLIs should use the explicit module
or Node entry point to avoid the common `casadi-reader` executable name.

## C++ and C

Build with CMake and a C++11 compiler; no third-party library is needed:

```sh
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
ctest --test-dir build --output-on-failure
cmake --install build --prefix /your/prefix
```

Installed CMake consumers can use `find_package(casadi_reader CONFIG REQUIRED)`
and link `casadi_reader::casadi_reader`. Headers are
`<casadi_reader/reader.hpp>` and `<casadi_reader/reader.h>`.

```cpp
casadi_reader::Document graph("model.casadi");
std::string json = graph.json();
casadi_reader::Document resource("resource.casadi", true, true);
auto bytes = resource.read_blob(0, 0, 64);
```

```c
char error[1024];
cr_document *doc = cr_open("model.casadi", 0, 0, error, sizeof(error));
if (doc) {
  puts(cr_json(doc)); /* pointer valid until cr_close */
  cr_close(doc);
} else {
  fprintf(stderr, "%s\n", error);
}
```

The C ABI catches exceptions and reports errors through caller-owned buffers.
Handles own their source streams; lazy blob slices seek directly to encoded
file ranges. C/C++ blob indices and byte offsets are zero-based. Do not share
one handle between concurrent operations. Native eager archive-to-JSON expansion
is limited to 1,000,000 bytes; use lazy mode for larger archives.

## MATLAB

```sh
cmake -S . -B build -DCASADI_READER_MATLAB=ON
cmake --build build
```

```matlab
addpath('matlab');
addpath('build/matlab');
graph = casadi_reader.read('model.casadi');
document = casadi_reader.Document('resource.casadi', true, true);
cleanup = onCleanup(@() delete(document));
metadata = document.data();
bytes = document.readBlob(1, 0, 64);
```

`Document.json()` returns JSON text; `data()` uses MATLAB's `jsondecode`.
The package ZIP can include the built MEX. MEX binaries are platform-specific;
this prototype has been tested with MATLAB R2024b on Linux.

## Julia

From this checkout, build the library and instantiate the Julia environment:

```sh
julia --project=julia -e 'using Pkg; Pkg.instantiate(); include("julia/deps/build.jl")'
```

```julia
using CasadiReader
graph = read_casadi("model.casadi")
document = read_resource("resource.casadi"; lazy=true)
try
    metadata = data(document)
    bytes = read_blob(document, 1, 0, 64)
finally
    close(document)
end
```

The source archive is a self-contained Julia project, including the native
sources in `deps/reader`. `Pkg.build("CasadiReader")` needs CMake and a C++
compiler. Alternatively set `CASADI_READER_LIBRARY` to an existing standalone
reader library before starting Julia. Tested with Julia 1.6.2 on Linux.

MATLAB and Julia blob indices are one-based; byte offsets remain zero-based.
**Object references inside the JSON contract remain zero-based in every language.**
For example, a Julia consumer accesses the root as `graph["objects"][graph["root"]+1]`.

## JSON contract

Graph documents have `format: "casadi_json"`, `version: 1`,
`serializationProtocol: 3`, a `root` object index, and an `objects` array.
References are indices; shared nodes are stored once; null references stay null.

- `kind: "function"`: name, type, input/output sparsities and names, input nodes,
  and instructions containing node references and argument/result work slots.
- `kind: "mx"`: operation ID/name, dependency and sparsity references, constants
  and node-specific `info`. Indexing nodes also have a normalized `mapping`.
  Constants are numeric strings, including nonfinite values; decimal spelling
  may differ between implementations.
- `kind: "sparsity"`: shape and compressed-column `colind` / `row` arrays.

`info` is reconstructed from serialized members and tested against native
`MX.info()`. It does not prescribe viewer layout or styling. The representation
is not lossless and cannot be written back to `.casadi` by this prototype.

Lazy Resource payloads serialize as small descriptors with `offset`, `byteLength`
and `encoding`. Retrieving bytes requires the live document/blob and its original
source; descriptors alone are not portable archive copies. Lazy mode defers
opaque payloads, not all numerical arrays or graph nodes. Eager mode is default.
Payload encoding is checked on access; declared extents are checked on opening.

## Supported subset

The fixtures come from CasADi 3.8.1 default `Function.save()` files: MX arithmetic,
sparse matrices, gathers, slices and entry assignments. Supported layouts are
ProtoFunction 2, FunctionInternal 8, XFunction 1, MXFunction 3, little-endian
protocol 3. Unsupported operations/layouts fail explicitly. SX functions, nested
function calls, plugins, JIT, nonempty option/cache dictionaries and debug
serialization are outside this prototype. It is not a general reader for every
CasADi file or version, nor a hardened untrusted-file service.

Resource entry points accept a **raw SerializingStream containing one Resource**.
This tests the embedded ZIP representation used by FMUs, but **does not yet read
an entire saved FmuFunction**. No FMU is loaded or executed.

## Scheme, tests and packaging

`schemes/serialization_scheme.json` vendors CasADi's checked-in
`misc/serialization_scheme.json`. It is a source-derived serializer index and
named-field contract, **not a complete executable deserialization grammar**.
`scripts/generate-reader-assets.py` consumes this JSON and emits three checked-in
source assets: `src/scheme.js`, `python/casadi_reader/_scheme.py`, and
`native/src/scheme.hpp`. These contain runtime protocol constants, operation IDs
and class versions, omitting the C++ source index. Supported positional layouts
are still implemented explicitly in the readers.

`npm run build` regenerates the assets and bundles the JavaScript. `npm pack`
runs that build automatically. Python packages contain the generated Python
module, so neither Python nor JavaScript parses the scheme JSON at runtime.
Build tools are development dependencies only.

CI checks `npm run check:generated` **before** rebuilding, rejecting stale
committed assets. It builds and tests the native/Python readers, then produces
wheel/sdist and npm artifacts. A browser test serves the extracted npm tarball
over HTTP and checks that decoding needs one JavaScript request and no scheme
JSON request. CI uploads build artifacts; it does not publish packages.

```sh
node scripts/vendor-scheme.mjs ../serialization-scheme/misc/serialization_scheme.json
python scripts/generate-reader-assets.py
npm ci
npm run check:generated
npm test
npm run test:browser
PYTHONPATH=python python -m unittest discover -s python/tests -v
CASADI_READER_LIBRARY="$PWD/build/libcasadi_reader.so" julia --project=julia julia/test/runtests.jl
```

Set `CASADI_READER_NATIVE` to the native CLI to enable Python/native agreement
tests. Python tests also compare JavaScript when Node is available. Native CasADi
is used only to regenerate fixtures (`scripts/generate-fixtures.py` and
`scripts/generate-resource-fixture.cpp`), never to run the readers. Tests check
native graph/metadata oracles and deferred 16 MiB payload access.

Create unpublished artifacts with:

```sh
python -m build
npm pack
python scripts/package-bindings.py --output dist --mex build/matlab/casadi_reader_mex.mexa64
```

This produces Python wheel/sdist, npm tarball, native and Julia source archives,
and a MATLAB ZIP. It does not register packages or upload releases. The adjacent
`casadi-viz` proof of concept consumes the npm package through a local dependency.

Licensed LGPL-3.0-or-later, consistent with the serialization definitions and
operation IDs used here.
