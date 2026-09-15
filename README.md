# @casadi/casadi-reader

Read CasADi serialization into typed fields, values, containers and shared
references, without installing CasADi or loading its plugins.

The reader does not interpret SX/MX instructions, name mathematical operations,
reconstruct entry mappings, or build visualization graphs. Those tasks belong
in [casadi-viz](https://github.com/casadi/casadi-viz). An ONNX-backed function is
read as serialized configuration and model bytes; the reader never runs ONNX.

JavaScript, Python, C, C++, MATLAB and Julia expose the same structural document
contract. C and C++ share a native engine; MATLAB and Julia bind that engine.
Only JavaScript packaging and publishing are currently enabled in CI.

## API

```js
import {decode, open} from '@casadi/casadi-reader';

const document = decode(serializedText);
const fromFile = await open(file, {lazy: true}); // browser File/Blob
const root = document.objects[document.root];
console.log(root.type, root.fields);
```

`decode()` accepts encoded `.casadi` text. `open()` accepts a File/Blob.
`decodeCasadi` remains an alias for `decode`; both return structural documents.

The output is ordinary JavaScript data:

```js
{
  format: 'casadi_serialization',
  version: 1,
  serializationProtocol: 3,
  root: 8,
  roots: [{$ref: 8}],
  objects: [
    // ... shared objects ...
    {
      type: 'Function',
      fields: [
        {name: 'Function::null', type: 'bool', value: false, offset: 19, byteLength: 1},
        // Serialized field order and duplicate field names are preserved.
      ],
      layouts: ['MXFunction::serialize_body', /* base layouts ... */],
      offset: 18,
      byteLength: 1234
    }
  ]
}
```

The example's indices and byte counts are illustrative. `$ref` values are
zero-based indices into `objects`. Shared definitions appear once, even when
referenced by several functions. Inline structures have their own `type` and
`fields`. Vectors are arrays, pairs are two-element arrays, and maps are
`{$map: [[key, value], ...]}` so arbitrary key types and field order survive.
Repeated serializer fields remain repeated entries, not overwritten properties.
64-bit integers outside JavaScript's exact range use `{$integer: "..."}`;
nonfinite floating-point values use `{$float: "..."}`. Byte offsets count decoded
wire bytes from the stream start, not characters in its a–p encoding.

A file can contain several roots; `roots` retains them in order. `root` is a
convenience index for a single shared-object root, otherwise null.

## Lazy bytes

```js
const document = await open(resourceFile, {type: 'Resource', lazy: true});
const root = document.objects[document.root];
const blob = root.fields.find(f => f.name === 'ZipMemResource::blob').value;
const firstBytes = await blob.read(0, 64);
```

`type` selects a raw `SerializingStream` root instead of FileSerializer framing.
Resource streams use the same archive representation embedded inside FMUs;
complete saved FMU functions are not yet a validated layout family.

Lazy byte handles expose `offset`, `byteLength` and `read(offset, length)`.
Text-input reads are synchronous; File/Blob reads are asynchronous. JSON output
contains a small descriptor and requires the original source to retrieve bytes.

Opaque streams are deferred in lazy mode. Large serialized strings are also
deferred (default `lazyThreshold: 65536` bytes). Smaller strings are decoded as
UTF-8 where possible; other strings retain their bytes as `{$bytes: [...]}` in
eager mode or a lazy byte handle in lazy mode. No archive extraction occurs.

Lazy File/Blob opening loads metadata pages and skips payload pages by their
declared lengths. It requires unpadded encoded files, as emitted by CasADi.
Text input accepts surrounding whitespace but necessarily retains the supplied
encoded string. Graph fields and containers are currently eager; lazy mode
specifically concerns opaque byte payloads.

## Browser and CLI

Published packages contain bundled browser ESM with the layout data embedded.
They do not fetch or parse the source scheme JSON at runtime. A browser can
import a pinned `https://unpkg.com/@casadi/casadi-reader@VERSION/dist/index.js`
from a module script without a bundler or an import map.

```sh
npx @casadi/casadi-reader model.casadi model.json
# Or, for a raw Resource stream:
npx @casadi/casadi-reader --type Resource --lazy resource.casadi
```

There are no runtime dependencies. Building the npm package needs Node 22+,
Python 3.9+ and the development dependencies in package-lock.json.

## Scheme and coverage

CasADi's `misc/generate_serialization_scheme.py` produces the vendored
`schemes/serialization_scheme.json`: decoding rules and validation metadata,
without source bodies, pack expressions, source locations or extraction offsets.
Field bindings are retained only when decoding expressions can reference them.
`npm run generate` generates all six readers. The generic engines
execute field, base-layout, repetition, condition and discriminator instructions;
they contain no SX/MX-specific decoding methods. A small `Generator` base class
and language subclasses in `scripts/reader_generators.py` emit scheme data and
copy runtime templates from `scripts/templates`. Edit templates, then regenerate.
Use `--scheme PATH --output-root DIR` with `scripts/generate-reader-assets.py`
to generate readers for another extracted scheme without changing this checkout.

The extractor includes inline serializers, inheritance and tensor metadata
helpers. Inherited serializers and template aliases are explicit layouts with
call instructions; readers perform no C++ inheritance lookup. It derives operation dispatch families from CasADi's native dispatcher
and plugin registrations from the source. No mathematical evaluation occurs.

Coverage is still experimental. Native plain/debug fixture pairs validate MX,
SX, nested calls, mappings, constants, ONNX-backed functions and Resource streams.
The debug files independently check serialized field names and primitive tags;
ordinary undecorated files use the same layouts. Tests also exercise a new
function discriminator supplied entirely as layout data.

This is **not yet a guarantee that every CasADi class/version can be read**.
Unsupported lowering, missing field types, absent layouts and unknown
discriminators fail explicitly. Current fixtures target the CasADi 3.8.1 source
snapshot, little-endian protocol 3. Expanding coverage belongs in the scheme
extractor and fixtures, not mathematical interpretation in the reader. Advanced
consumers can supply a compiled schema through `decode(text, {scheme})`.

```sh
npm ci
npm run check:generated
npm test
npm run test:browser
npm pack
```

CI rejects stale generated assets before rebuilding. Browser tests serve the
extracted npm tarball over HTTP and verify one JavaScript request with no scheme
JSON or CasADi runtime request. Native CasADi is used only when regenerating the
fixtures, via `scripts/generate-fixtures.py` and the Resource fixture generator.

## Other languages

Python is dependency-free: `PYTHONPATH=python python3 -m casadi_reader model.casadi`.
`casadi_reader.read_casadi(path)` returns the same typed records as JavaScript;
`to_json(document)` makes them portable to the viewer. Use `lazy=True` for byte
handles and keep their source open while reading them.

Build the standalone native library and CLI using the root `CMakeLists.txt`.
C uses `cr_open_type` for files or `cr_decode` for copied encoded input;
`cr_json` exposes the structural JSON, valid until `cr_close`.
C++ wraps this lifetime in `casadi_reader::Document`. Both accept an optional
raw root type, such as `Resource`. Lazy byte access checks ranges and requires
an open document. The native engine limits collection/eager byte counts to one
million, nesting to 256, and input size to 1 GiB; larger opaque payloads can use
lazy mode within the file limit.

MATLAB uses `casadi_reader.read(path)` or a `casadi_reader.Document` for lazy
bytes; compile `matlab/casadi_reader_mex.cpp` with the native engine.
Julia uses `CasadiReader.read_casadi(path)` or `Document(path; lazy=true)` and
loads the native library through `CASADI_READER_LIBRARY`.

`python/tests/test_reader.py` compares every field and offset against JavaScript
on all plain/debug fixtures, and also checks the native CLI when
`CASADI_READER_NATIVE` points to it. `scripts/test-bindings.py` runs the same
fixture comparisons in MATLAB/Julia; see its `--help` for local paths. Native
`native/tests/api.c` exercises the C ABI, copied input and lazy payload bounds.
These local language tests do not add language packaging to CI.

## Publishing

`publish.yml` publishes on a published GitHub release, after tests. The release
tag must equal `v` plus the package version. Prereleases use npm's `next` tag;
stable versions use `latest`.

The npm Trusted Publisher configuration is GitHub organization `casadi`,
repository `casadi-reader`, workflow `publish.yml`, with no environment name and
with direct `npm publish` allowed. Publishing uses OIDC and provenance, with no
npm token secret. See [npm's documentation](https://docs.npmjs.com/trusted-publishers/).

The reader implementation is MIT licensed. The vendored scheme is derived from
CasADi; upstream attribution and license texts are retained in NOTICE and LICENSES.
