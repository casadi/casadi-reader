"""Regenerate structural fixtures with CasADi; no viewer interpretation is used."""
import argparse
from pathlib import Path
import casadi as ca

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--onnx', action='store_true', help='Also generate the ONNX plugin fixture')
args = parser.parse_args()
root = Path(__file__).resolve().parents[1]
fixtures = root/'test/fixtures'
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
x = ca.SX.sym('x', 3)
f = ca.Function('sx_basic', [x], [ca.sin(x)+2*x])
cases['sx'] = f
cases['sx_nested'] = ca.Function('sx_nested', [x], [f.call([x], False, True)[0]])
x = ca.MX.sym('x', 3)
cases['mx_sx_call'] = ca.Function('mx_outer', [x], [f(x)])
x = ca.MX.sym('x', 2)
y = ca.MX.sym('y', 2)
cases['mx_constants'] = ca.Function('mx_constants', [x], [x+0.5])
cases['mx_new_ops'] = ca.Function('mx_new_ops', [x, y], [ca.hypot(x, y)])
cases['mapped_sx'] = f.map(3)
option_x = ca.SX.sym('x', 2)
cases['options_sx'] = ca.Function('options_sx', [option_x], [option_x+option_x], {'forward_options': {'ad_weight':0.25,'enable_fd':True}, 'jit_options': {'flags':['-O2','-g']}})
cases['switch_sx'] = ca.Function.if_else('switch_sx', f, f)
for name, f in cases.items():
    for debug in (False, True):
        f.save(str(fixtures/(name+('.debug' if debug else '')+'.casadi')), {'debug': debug})
if args.onnx:
    import onnx
    from onnx import helper, TensorProto
    import tempfile
    graph = helper.make_graph([helper.make_node('Identity', ['x'], ['y'])], 'opaque',
        [helper.make_tensor_value_info('x', TensorProto.FLOAT, [1, 2])],
        [helper.make_tensor_value_info('y', TensorProto.FLOAT, [1, 2])])
    model = helper.make_model(graph, opset_imports=[helper.make_opsetid('', 17)])
    model.ir_version = 8
    with tempfile.TemporaryDirectory() as directory:
        path = Path(directory)/'opaque.onnx'
        onnx.save(model, str(path))
        f = ca.GraphBuilder(str(path)).create('opaque')
        for debug in (False, True):
            f.save(str(fixtures/('onnx'+('.debug' if debug else '')+'.casadi')), {'debug': debug})
        (fixtures/'onnx-model.bin').write_bytes(path.read_bytes())
