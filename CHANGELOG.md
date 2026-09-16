# 0.2.2

- Refresh all six generated readers from the CasADi 3.8.1 release serialization scheme (dafc81035257e0e57db5c65b2ac851a6239fb1c4).
- Correct MadMPEC integer-vector types and MX serialization dispatch according to the released scheme.

# 0.2.1

- Add independent native C, Julia and MATLAB readers; remove the Julia/MATLAB C wrappers.
- Generate all six implementations from explicit serializer field references and concrete container types.
- Resolve template specialization and C++ expressions in CasADi's scheme generator, not in runtime readers.
- Separate and format the C/C++ runtime templates for input handling, JSON, scheme execution and public APIs.
- Build and test Python, Julia, MATLAB, C and C++ distributions in CI; publish Python to PyPI with trusted publishing.
- Keep the prototype scheme version at 1, without compatibility code for prior incarnations.

# 0.2.0

- Generate JavaScript, Python, C/C++, MATLAB and Julia readers from the compact serialization scheme, with language-specific runtime templates.
- Decode MX/SX expression vectors and their ordered dependencies, in ordinary and debug files.
- Refresh serializer layouts, including irregular nonzero assignments and finite differences.
- Preserve typed fields and shared references for generic Function property inspection.
- Remove structural `offset` and `byteLength` fields; keep `root` and `roots`. Lazy byte payload handles retain their I/O metadata.
- Use explicit layout calls instead of runtime inheritance resolution.

Breaking change: structural records no longer expose byte spans. npm publication remains JavaScript-only; the other language readers are available as source.

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
