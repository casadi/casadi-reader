"""Build tiny native test objects in temporary directories; ship serialized text only."""
from importlib.metadata import distribution
import gc
import os
from pathlib import Path
import re
import subprocess
import tempfile
import zipfile

import casadi as ca

ROOT = Path(__file__).resolve().parents[1]


def objects():
    headers = Path(distribution("fmpy").locate_file("fmpy/c-code"))
    original = Path.cwd()
    with tempfile.TemporaryDirectory() as temporary:
        os.chdir(temporary)
        try:
            # ConstantFile stores only its relative path, not the matrix data.
            Path("constants.txt").write_text("1\n2\n3\n")
            yield "mx_constant_file", ca.MX(ca.Sparsity.dense(3, 1), "constants.txt")

            x = ca.SX.sym("x")
            f = ca.Function("fixture_external", [x], [x*x])
            f.generate("fixture_external.c")
            subprocess.run(["cc", "-shared", "-fPIC", "fixture_external.c", "-o", "fixture_external.so"], check=True)
            external = ca.external("fixture_external", "./fixture_external.so")
            assert float(external(3)) == 9
            yield "external", external
            del external

            for mode in ("source", "link", "embed"):
                options = {"jit": True, "jit_serialize": mode, "jit_temp_suffix": False,
                           "jit_name": "fixture_jit", "jit_cleanup": False,
                           "jit_options": {"name": "fixture_jit", "temp_suffix": False, "cleanup": False}}
                jit = ca.nlpsol("jit_solver", "sqpmethod", {"x": x, "f": (x-1)**2},
                                {**options, "qpsol": "qrqp", "print_header": False})
                yield "jit_" + mode, jit
                del jit
            dae = ca.DaeBuilder("fixture_fmi3")
            state = dae.add("x")
            dae.eq(dae.der(state), -state)
            dae.set_start("x", 1)
            files = dae.export_fmu({"with_serialization": False, "no_warning": True})
            xml = Path("modelDescription.xml")
            token = re.search('instantiationToken="([^"]+)"', xml.read_text()).group(1)
            # The exporter generates a random token; make both sides agree on a fixed one.
            for name in files:
                path = Path(name)
                if path.suffix in (".c", ".h", ".xml"):
                    path.write_text(path.read_text().replace(token, "0" * 32))
            files = dae.compile_fmu(files, {"include_dirs": [str(headers)]})
            dae.pack_fmu(files, {"path": "fixture_fmi3.fmu"})

            subprocess.run(["cc", "-shared", "-fPIC", "-I" + str(headers),
                            str(ROOT / "scripts/fixtures/fmi2.c"), "-o", "fixture_fmi2.so"], check=True)
            with zipfile.ZipFile("fixture_fmi2.fmu", "w") as archive:
                archive.write(ROOT / "scripts/fixtures/fmi2.xml", "modelDescription.xml")
                archive.write("fixture_fmi2.so", "binaries/linux64/fixture_fmi2.so")

            for version in (2, 3):
                name = f"fixture_fmi{version}"
                with zipfile.ZipFile(name + ".fmu") as archive:
                    archive.extractall(name)
                for mode, path in [("zip", name + ".fmu"), ("directory", name)]:
                    imported = ca.DaeBuilder(name, path, {"resource_serialize_mode": "link"})
                    function = imported.create("fmu", ["x"], ["ode"])
                    assert float(function(2)) == -2
                    yield f"fmi{version}_{mode}", function
                    del function, imported
                    gc.collect()
        finally:
            os.chdir(original)
