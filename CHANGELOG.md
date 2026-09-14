# 0.1.0

- Replace MX graph interpretation with a schema-driven structural reader.
- Read typed fields, inline structures, maps, shared references and byte ranges.
- Validate ordinary and debug serialization with the same generated layouts.
- Add SX, nested SX/MX calls, ONNX-backed function and additional MX fixtures.
- Defer byte payload decoding and File/Blob payload I/O.
- Move operation labels, mapping reconstruction and MX graph normalization to casadi-viz.

Breaking changes from 0.0.0-poc: `decodeCasadi` now returns
`casadi_serialization`, not `casadi_json`. Prefer `decode` and `open`.
The `/operations` export is removed. Raw Resource streams use
`decode(text, {type: 'Resource'})` or `open(file, {type: 'Resource'})`.
Other language prototypes remain deferred.
