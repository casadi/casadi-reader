"""Regenerate reader fixtures with the release-3.8.1 CasADi build."""
import json
from pathlib import Path
import casadi as ca
root = Path(__file__).resolve().parents[1]
x = ca.MX.sym('x', 4, 3)
cases = {
    'arithmetic': ca.Function('arithmetic', [x], [ca.sin(x)+x*x]),
    'mapping': ca.Function('mapping', [x], [x[[3, 0, 2], [2, 0]]]),
    'slice': ca.Function('slice', [x], [x[1:4, :]]),
}
y = ca.MX(x)
y[[0, 3], 1] = x[[1, 2], 0]
cases['assignment'] = ca.Function('assignment', [x], [y])
s = ca.MX.sym('s', ca.Sparsity.triplet(4, 3, [0, 2, 3, 1], [0, 0, 1, 2]))
cases['sparse'] = ca.Function('sparse', [s], [ca.sin(s)])
for name, f in cases.items():
    f.save(str(root/'test/fixtures'/f'{name}.casadi'))
    (root/'test/fixtures'/f'{name}.json').write_text(f.export_graph())
    (root/'test/fixtures'/f'{name}.info.json').write_text(json.dumps([f.instruction_MX(i).info() for i in range(f.n_instructions())]))
