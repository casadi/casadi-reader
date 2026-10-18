"""Write the release corpus with an installed CasADi: python generate-release-fixtures.py OUTDIR.

Run it once per CasADi release; files are named <kind>_<release>[.debug].casadi.
Record the outcome of each new file in test/fixtures/releases/expected.json.
"""
import sys
import casadi as ca

out = sys.argv[1]
release = ca.__version__.split('-')[0]
x, p, s = ca.MX.sym('x', 2), ca.MX.sym('p'), ca.SX.sym('s', 2)
nlp = {'x': x, 'p': p, 'f': (x[0]-p)**2 + x[1]**2, 'g': x[0]+x[1]}
kinds = {
    'mx': lambda: ca.Function('f', [x, p], [ca.sin(x)*p + x[0]]),
    'sx': lambda: ca.Function('g', [s], [ca.cos(s[0])*s[1]]),
    'map': lambda: ca.Function('g', [s], [ca.cos(s[0])*s[1]]).map(3),
    'ipopt': lambda: ca.nlpsol('solver', 'ipopt', nlp),
    'sqpmethod': lambda: ca.nlpsol('solver', 'sqpmethod', nlp, {'qpsol': 'qrqp'}),
    'qrqp': lambda: ca.qpsol('q', 'qrqp', {'x': x, 'f': ca.sumsqr(x), 'g': x[0]+x[1]}),
    'rootfinder': lambda: ca.rootfinder('r', 'newton', {'x': x, 'p': p, 'g': x**3 - p}),
    'interpolant': lambda: ca.interpolant('lut', 'linear', [[0, 1, 2]], [0, 1, 4]),
}
for kind, make in kinds.items():
    f = make()
    f.save(f'{out}/{kind}_{release}.casadi')
    f.save(f'{out}/{kind}_{release}.debug.casadi', {'debug': True})
