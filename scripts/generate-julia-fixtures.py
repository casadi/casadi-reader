"""Generate the shipped Julia corpus using the schema's pinned pip CasADi version.

Run after generate-reader-assets.py. Only generation requires CasADi; Pkg.test()
uses the committed .casadi files, reference JSON, and manifest on main.
"""
import argparse
import json
import os
from pathlib import Path
import hashlib
import sys
import struct

# Keep numerical plugins deterministic and avoid starting a thread per CPU.
os.environ.setdefault("OPENBLAS_NUM_THREADS", "1")
os.environ.setdefault("OMP_NUM_THREADS", "1")
import casadi as ca

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "python"))
from casadi_reader import read_casadi


def objects():
    """Small native objects exercising distinct serialization layouts."""
    x = ca.MX.sym("x", 3, 3)
    y = ca.MX.sym("y", 3, 3)
    v = ca.MX.sym("v", 3)
    s = ca.MX.sym("s", ca.Sparsity.diag(3))
    exprs = {
        "binary": x + y * x - y / (x + 1),
        "unary": ca.sin(x) + ca.cos(x) + ca.exp(x),
        "matmul": ca.mtimes(x, y), "sparse_matmul": ca.mtimes(s, s),
        "mixed_matmul": ca.mtimes(x, s) + ca.mtimes(s, y),
        "transpose": x.T, "sparse_transpose": s.T,
        "reshape": ca.reshape(x, 9, 1), "densify": ca.densify(s),
        "project": ca.project(x, ca.Sparsity.diag(3)),
        "dot": ca.dot(x, y), "bilin": ca.bilin(x, v, v),
        "rank1": ca.rank1(x, 2, v, v),
        "norms": ca.vertcat(ca.norm_1(x), ca.norm_fro(x), ca.norm_inf(x), ca.norm_2(v)),
        "extrema": ca.vertcat(ca.mmin(x), ca.mmax(x)),
        "det": ca.det(x), "inverse": ca.inv(x),
        "kron": ca.kron(x, y), "sparse_kron": ca.kron(s, s),
        "mixed_kron": ca.kron(x, s) + ca.kron(s, x),
        "concat": ca.vertcat(x, y), "horzcat": ca.horzcat(x, y),
        "diagcat": ca.diagcat(x, y),
        "split": ca.horzsplit(x, [0, 1, 3])[1],
        "vsplit": ca.vertsplit(x, [0, 1, 3])[1],
        "repmat": ca.repmat(x, 1, 3), "sum": ca.sum2(x),
        "slice": x[0:2, :], "gather": x[[0, 4, 8, 2]],
        "solve": ca.solve(x, v), "logic": ca.if_else(x > y, x, y),
        "monitor": x.monitor("fixture"),
        "assertion": x.attachAssert(v[0] > 0, "positive"),
        "logsumexp": ca.logsumexp(v),
        "constants": x + ca.DM([[0, 1, -1], [2, 0.5, 3], [4, 5, 6]]),
    }
    for name, expr in exprs.items():
        yield "mx_" + name, ca.Function("fixture_" + name, [x, y, v, s], [expr])
    for add in (False, True):
        for name, indices in [("slice", slice(0, 3)), ("vector", [0, 4, 8])]:
            z = ca.MX(x)
            if add:
                z[indices] += v
            else:
                z[indices] = v
            yield "mx_" + ("add_" if add else "set_") + name, ca.Function("fixture", [x, v], [z])
    sx = ca.SX.sym("sx", 3)
    f = ca.Function("inner", [sx], [ca.sin(sx) + sx * sx])
    yield "sx_function", f
    yield "sx_constants", ca.vertcat(sx, 0, 1, -1, 3, 1.25, ca.inf, -ca.inf, float("nan"))
    yield "sx_nested", ca.Function("nested", [sx], f.call([sx], False, True))
    yield "mx_expression", [x + y, x, y]
    yield "sx_expression", [sx * sx, sx]
    for X, name in [(ca.MX, "mx"), (ca.SX, "sx")]:
        a, b = X.sym("a"), X.sym("b")
        unary = ["sqrt", "sin", "cos", "tan", "asin", "acos", "atan", "sinh", "cosh", "tanh",
                 "asinh", "acosh", "atanh", "exp", "log", "log1p", "expm1", "erf", "erfinv",
                 "fabs", "sign", "floor", "ceil"]
        expressions = [getattr(ca, op)(a) for op in unary]
        expressions += [-a, a+a, a-b, a*b, a/b, a**b, a**2.5, a**2, 1/a, a < b, a <= b, a == b, a != b]
        expressions += [getattr(ca, op)(a, b) for op in ["atan2", "fmin", "fmax", "fmod", "remainder", "copysign", "hypot", "logic_and", "logic_or"]]
        expressions += [ca.logic_not(a), ca.if_else(a, b, 0), a.printme(b)]
        if X is ca.MX:
            expressions += [X.unary(ca.OP_ASSIGN, a), X.binary(ca.OP_LIFT, a, b)]
        yield name + "_operators", expressions
    yield "mapped", f.map(3)
    yield "openmp_mapped", f.map(3, "openmp")
    yield "map_reduction", f.map(3, [False], [True], {})
    yield "thread_mapped", f.map(3, "thread", 2)
    yield "mapsum", f.map("summed", "serial", 3, [], [0], {})
    yield "mapaccum", f.mapaccum(3)
    yield "switch", ca.Function.if_else("switched", f, f)
    yield "forward", f.forward(2)
    yield "reverse", f.reverse(2)
    yield "jacobian", f.jacobian()
    for method in ["forward", "backward", "central", "smoothing"]:
        fd = ca.Function("fd", [sx], [ca.sin(sx)], {
            "enable_fd": True, "enable_forward": False, "enable_reverse": False,
            "fd_method": method,
        })
        yield "finite_difference_" + method, fd.forward(1)
    for plugin in ["linear", "bspline"]:
        interp = ca.interpolant("interp", plugin, [[0., 1., 2., 3., 4.]], [0., 1., 4., 9., 16.])
        yield "interpolant_" + plugin, interp
        yield "interpolant_jac_" + plugin, interp.jacobian()
    q = ca.SX.sym("q")
    p = ca.SX.sym("p")
    for plugin in ["rk", "collocation", "cvodes", "idas"]:
        yield "integrator_" + plugin, ca.integrator("integrate", plugin, {"x": q, "p": p, "ode": p * q}, 0, 0.1)
    for plugin in ["newton", "fast_newton", "kinsol", "bisection", "nlpsol"]:
        options = {"nlpsol": "sqpmethod", "nlpsol_options": {"qpsol": "qrqp"}} if plugin == "nlpsol" else {}
        yield "rootfinder_" + plugin, ca.rootfinder("root", plugin, {"x": q, "p": p, "g": q*q-p}, options)
    for plugin in ["qr", "ldl", "tridiag", "lsqr", "csparse", "csparsecholesky", "lapacklu", "lapackqr", "mumps", "symbolicqr"]:
        yield "linsol_" + plugin, ca.Linsol("linear", plugin, ca.Sparsity.dense(3, 3))
    for plugin in ["sqpmethod", "qrsqp", "feasiblesqpmethod", "ipopt", "alpaqa", "blocksqp", "bonmin", "sleqp", "fatrop", "uno"]:
        options = {"qpsol": "qrqp"} if plugin in ("sqpmethod", "qrsqp", "feasiblesqpmethod") else {}
        yield "nlpsol_" + plugin, ca.nlpsol("solver", plugin, {"x": q, "f": (q-1)**2, "g": q}, options)
    for plugin in ["qrqp", "ipqp", "osqp", "proxqp", "highs", "daqp", "clp", "cbc", "qpoases", "piqp", "superscs", "fatrop", "hpipm", "nlpsol"]:
        options = {"nlpsol": "sqpmethod", "nlpsol_options": {"qpsol": "qrqp"}} if plugin == "nlpsol" else {}
        yield "conic_" + plugin, ca.conic("qp", plugin, {"h": ca.Sparsity(2, 2) if plugin in ("clp", "cbc") else ca.Sparsity.diag(2), "a": ca.Sparsity.dense(1, 2)}, options)
    compact = ca.Sparsity.triplet(4, 4, [0, 2, 0, 2], [0, 0, 2, 2])
    yield "mx_pseudo_dense", ca.mtimes(ca.MX.sym("compact_a", compact), ca.MX.sym("compact_b", compact))
    yield "mx_sparse_contract", ca.kron_contract(s, s, True)
    yield "mx_minus_one", ca.MX(-1)
    for name, indices in [("vector", [0, 3, 8]), ("slice", slice(0, 3)), ("slice2", [0, 1, 3, 4, 6, 7])]:
        selected = ca.vec(x)[indices]
        yield "mx_add_scatter_" + name, x + ca.jtimes(selected, x, ca.MX.sym("seed", selected.shape), True)
    yield "mx_inverse_node", ca.inv_node(x)
    yield "mx_dump", x.dump("fixture", {"dir": ".", "format": "mtx"})
    yield "mx_constant_pool", ca.MX(ca.DM([1, 2, 3]), "fixture_constants")
    for label, left, right in [("dense", x, y), ("dense_sparse", x, s), ("sparse_dense", s, x)]:
        yield "mx_contract_" + label, ca.kron_contract(left, right, True)
    # Derivatives of dynamic gathers exercise the corresponding scatter/add nodes.
    dynamic = ca.MX.sym("dynamic", 9)
    indices = ca.MX.sym("indices", 2)
    for label, selection in [("param", (indices,)), ("param_param", (indices, indices)),
                             ("slice_param", (ca.Slice(0, 2), indices)), ("param_slice", (indices, ca.Slice(0, 2)))]:
        selected = dynamic.get_nz(False, *selection)
        seed = ca.MX.sym("seed", selected.shape)
        yield "mx_scatter_" + label, ca.jtimes(selected, dynamic, seed, True)
        yield "mx_scatter_add_" + label, dynamic + ca.jtimes(selected, dynamic, seed, True)
    yield "mx_gather_slice2", dynamic[[0, 1, 3, 4, 6, 7]]
    yield "mx_scatter_slice2", ca.jtimes(dynamic[[0, 1, 3, 4, 6, 7]], dynamic, ca.MX.sym("seed", 6), True)
    lifted = ca.MX.sym("lifted")
    yield "nlpsol_scpgen", ca.nlpsol("lifted_solver", "scpgen", {"x": lifted, "f": (lifted-1)**2}, {"qpsol": "qrqp"})
    yield "nlpsol_convexify", ca.nlpsol("convex", "sqpmethod", {"x": q, "f": (q-1)**2}, {"qpsol": "qrqp", "convexify_strategy": "eigen-reflect"})
    for plugin in ["ipopt", "feasiblesqpmethod"]:
        options = {"convexify_strategy": "eigen-reflect"}
        if plugin == "feasiblesqpmethod":
            options["qpsol"] = "qrqp"
        yield "convexify_" + plugin, ca.nlpsol("convex", plugin, {"x": q, "f": (q-1)**2}, options)
    yield "mx_norm2", ca.norm_2(x)
    yield "mx_find", ca.find(v)
    yield "mx_low", ca.low(v, ca.MX(0.5), {})
    yield "mx_cast", ca.sparsity_cast(s, ca.Sparsity.dense(3, 1))
    yield "mx_diagsplit", ca.diagsplit(ca.diagcat(x, y), [0, 3, 6])
    yield "mx_convexify", ca.convexify(x, {"strategy": "eigen-reflect"})
    yield "mx_einstein", ca.einstein(ca.vec(x), ca.vec(y), [3, 3], [3, 3], [3, 3], [-1, -2], [-2, -3], [-1, -3])
    yield "mx_kron_contract", ca.mtimes(ca.kron(x, y), ca.MX.sym("rhs", 9))
    yield "mx_sparse_kron_contract", ca.mtimes(ca.kron(s, y), ca.MX.sym("rhs", 9))
    yield "mx_dense_sparse_kron_contract", ca.mtimes(ca.kron(x, s), ca.MX.sym("rhs", 9))
    idx = ca.MX.sym("index", 2)
    for label, indices in [("param", (idx,)), ("param_param", (idx, idx)),
                           ("slice_param", (ca.Slice(0, 2), idx)), ("param_slice", (idx, ca.Slice(0, 2)))]:
        yield "mx_get_" + label, x.get_nz(False, *indices)
    z = ca.MX(x)
    z.set_nz(ca.MX.sym("value", 2), False, idx)
    yield "mx_set_param", z
    coefficients = ca.MX.sym("coefficients", 4)
    knots = [[0., 0., 0., 0., 1., 1., 1., 1.]]
    yield "mx_bspline_parametric", ca.bspline(v[0], coefficients, knots, [3], 1, {})
    yield "blazing_spline", ca.blazing_spline("blazing", knots, {})
    yield "blazing_spline_parametric", ca.blazing_spline("blazing_parametric", [8], {})
    for name, obj in {
        "integer": 2**53 + 1, "negative_integer": -(2**53 + 1),
        "double": 1.25, "nan": float("nan"), "inf": float("inf"), "minus_inf": -float("inf"),
        "string": 'quotes"\\\n\t\r\x00 and unicode τ',
        "integers": [0, -1, 2**53 + 1], "doubles": [1.5, -2.5], "strings": ["", "hello", "τ"],
        "sparsity": ca.Sparsity.diag(3), "sparsities": [ca.Sparsity(0, 0), ca.Sparsity.dense(2, 3)],
        "dm": ca.DM([[1, 0], [0, -2]]), "dms": [ca.DM(), ca.DM.eye(2)],
        "functions": [f, f], "empty_mx": ca.MX(), "empty_sx": ca.SX(),
        "generic_bools": ca.GenericType([True, False]),
        "generic_values": ca.GenericType([ca.GenericType(1), ca.GenericType("x")]),
        "generic_value_matrix": ca.GenericType([[ca.GenericType(1)], [ca.GenericType("x")]]),
        "generic_bool": ca.GenericType(True), "generic_int": ca.GenericType(42),
        "generic_double": ca.GenericType(1.5), "generic_string": ca.GenericType("hello"),
        "generic_ints": ca.GenericType([1, 2]), "generic_doubles": ca.GenericType([1., 2.]),
        "generic_strings": ca.GenericType(["a", "b"]),
        "generic_dict": ca.GenericType({"flag": True, "nested": {"value": 2.5}}),
        "generic_dicts": ca.GenericType([{"x": 1}, {"x": 2}]),
        "generic_function": ca.GenericType(f), "generic_functions": ca.GenericType([f]),
        "generic_int_matrix": ca.GenericType([[1, 2], [3, 4]]),
        "generic_double_matrix": ca.GenericType([[1., 2.], [3., 4.]]),
        "generic_string_matrix": ca.GenericType([["a"], ["b"]]),
    }.items():
        yield name, obj


def relative_jit_path(text):
    """Relocate a JIT library just as a portable serialized artifact requires.

    The only edit is a length-prefixed filename; native unpack() below verifies
    that the relocated file is still a valid CasADi serialization.
    """
    def encoded_string(value):
        data = value.encode()
        payload = struct.pack("<i", len(data)) + data
        return "".join(chr(97 + (b & 15)) + chr(97 + (b >> 4)) for b in payload)

    old = encoded_string(str(Path.cwd()) + "/./fixture_jit.so")
    new = encoded_string("./fixture_jit.so")
    if text.count(old) != 1:
        raise AssertionError("Unexpected JIT library serialization; review relocation")
    return text.replace(old, new)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--max-mib", type=float, default=10, help="Fail if the uncompressed corpus exceeds this size")
    parser.add_argument("--output", type=Path, default=ROOT / "julia/test/fixtures")
    args = parser.parse_args()
    version = json.loads((ROOT / "schemes/serialization_scheme.json").read_text())["casadi_version"]
    if ca.__version__ != version:
        parser.error(f"Install casadi=={version}; found {ca.__version__}")
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    cases = []
    native_limitations = {}
    references = {}

    def record(name, text, kind=""):
        path = out / (name + ".casadi")
        path.write_text(text)
        case = {"file": path.name, "type": kind}
        if name in ("corpus_mx_constant_pool.debug", "corpus_mx_constant_file.debug"):
            # These subclasses write their own type label, but the native
            # deserializer and schema expect ConstantMX::type.
            reason = "Expected serialized field ConstantMX::type"
            try:
                read_casadi(path)
            except ValueError as exc:
                if reason not in str(exc):
                    raise
            else:
                raise AssertionError("Constant debug rejection changed; review the fixture")
            case["error"] = reason
            cases.append(case)
            return
        decoded = read_casadi(path, **({"type": kind} if kind else {}))
        content = json.dumps(decoded, ensure_ascii=True, sort_keys=True, separators=(",", ":")) + "\n"
        digest = hashlib.sha256(content.encode()).hexdigest()
        expected = references.setdefault(digest, path.with_suffix(".reader.json"))
        expected.write_text(content)
        case["expected"] = expected.name
        cases.append(case)

    # Preserve existing integration cases, including Resource and ONNX payloads.
    for path in sorted((ROOT / "test/fixtures").glob("*.casadi")):
        record(path.stem, path.read_text(), "Resource" if path.stem == "resource" else "")
    from itertools import chain
    from fixture_native import objects as native_objects
    for name, obj in chain(objects(), native_objects()):
        for debug in (False, True):
            serializer = ca.StringSerializer({"debug": debug})
            serializer.pack(obj)
            text = serializer.encode()
            if name in ("jit_link", "jit_embed"):
                text = relative_jit_path(text)
            # Check the upstream round trip too; record known upstream limitations.
            try:
                ca.StringDeserializer(text).unpack()
            except RuntimeError as exc:
                known = (
                    "does not support deserialize" in str(exc)
                    or name in ("nlpsol_feasiblesqpmethod", "convexify_feasiblesqpmethod", "mx_constant_pool", "mx_constant_file")
                    or (name.startswith("generic_") and "Not implemented: OT_" in str(exc))
                )
                if not known:
                    raise
                native_limitations[name + (".debug" if debug else "")] = str(exc).strip()
            record("corpus_" + name + (".debug" if debug else ""), text)
        del obj
    manifest = {"casadi_version": version, "cases": cases, "native_roundtrip_limitations": native_limitations}
    (out / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    retained = {"manifest.json"} | {c["file"] for c in cases} | {c["expected"] for c in cases if "expected" in c}
    for path in out.iterdir():
        if path.is_file() and (path.suffix == ".casadi" or path.name.endswith(".reader.json")) and path.name not in retained:
            path.unlink()
    size = sum((out / name).stat().st_size for name in retained)
    if size > args.max_mib * 1024**2:
        raise RuntimeError(f"Corpus is {size / 1024**2:.2f} MiB, exceeding the {args.max_mib} MiB budget")
    print(f"Corpus size: {size / 1024**2:.2f} MiB")
    rejected = sum("error" in case for case in cases)
    print(f"Wrote {len(cases)} fixtures ({rejected} expected reader rejections) to {out}")


if __name__ == "__main__":
    main()
