# @casadi/casadi2json — proof of concept

Decode a `.casadi` file into ordinary JSON using JavaScript alone. No CasADi,
CasADi WASM, Python, native library, network or runtime dependency is required
to decode a file. Files are inspected, never evaluated.

```js
import {decodeCasadi} from '@casadi/casadi2json';
const document = decodeCasadi(await file.text()); // Browser File
```

```sh
node bin/casadi2json.js model.casadi model.json
npm test
```

This is a local prototype, not an npm release. Install with `npm install /path/to/casadi2json`.

## JSON contract

The document has `format: "casadi_json"`, `version: 1`, `serializationProtocol: 3`,
a `root` object index, and an `objects` array. References are object indices;
`null` stays null. Shared nodes are stored once, avoiding recursive expansion.

- `kind: "function"`: name, type, port names, input/output sparsity references,
  input nodes and instructions. Each instruction references its MX node and
  records its argument/result work slots. Work slots can be reused.
- `kind: "mx"`: numerical operation ID and name, dependency references, sparsity,
  constants, and node-specific `info`. Indexing nodes also have a normalized
  `mapping` array. Constants are strings, preserving nonfinite values in JSON.
- `kind: "sparsity"`: shape and compressed-column `colind` / `row` arrays.

`info` is reconstructed from serialized members; the decoder does not call
CasADi's `info()` method. Supported indexing metadata is checked against native
`MX.info()`. This representation describes mathematics and instructions, not
viewer layout, colors, labels, or tooltips. It is not a lossless encoding of all
execution options, caches or serialization bytes, and cannot be written back
to `.casadi` by this prototype.

## Deliberate limits

Initially tested with CasADi 3.8.1 default `Function.save()` files containing MX
arithmetic, sparse matrices, explicit index gathers, slices and entry assignments.
The reader supports a bounded subset of primitive unary/binary operations and
constant representations. It rejects unsupported node kinds, SX functions,
function-call nodes, plugin functions, JIT, nonempty option/cache dictionaries,
debug-decorated serialization and unknown class versions. It is not a general
reader for every CasADi version or every serialized CasADi type.

Supported class layouts are ProtoFunction 2, FunctionInternal 8, XFunction 1,
and MXFunction 3, with little-endian serialization protocol 3. The file does
not declare a CasADi release number; compatibility is determined from those
protocol/class versions. Malformed references, truncated files and excessive
lengths/nesting are rejected. These bounds are preliminary, not a hardened
untrusted-file service.

## Validation and maintenance

Fixtures were produced by native `Function.save()`. Tests compare decoded
instructions, sparsities and mappings against native `export_graph()` output,
and node metadata against `MX.info()`. Python/CasADi are needed only to regenerate
the fixtures with `python scripts/generate-fixtures.py`; npm tests use checked-in
files and run without them.

The corresponding `casadi-viz` proof-of-concept branch adds an adapter and a file
viewer. Keep both repositories adjacent to use its local package dependency.

The wire format is positional: skipping an unknown class is generally impossible
without knowing how its fields are serialized. A production version would benefit
from versioned serialization schemas generated in CasADi CI, with cross-version
fixtures. Moving the parser into this package isolates that maintenance burden;
it does not eliminate it.

Licensed LGPL-3.0-or-later, consistent with the CasADi serialization definitions
and operation IDs used to implement this decoder. No package or repository has
been published by this proof of concept.
