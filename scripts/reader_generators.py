"""One Python entry point, six direct-code backends and shared runtime templates."""

from reader_model import reader_model


class Generator:
    templates = {}

    def __init__(self, root, scheme):
        self.root = root
        self.data = reader_model(scheme)

    def generate(self):
        return {
            output: (self.root / "scripts/templates" / template).read_text()
            for output, template in self.templates.items()
        }


class JavaScriptGenerator(Generator):
    templates = {
        "src/index.js": "javascript/index.js.in",
        "src/source.js": "javascript/source.js.in",
    }

    def generate(self):
        from codegen.javascript import JavaScript

        return {**super().generate(), "src/generated.js": JavaScript(self.data).generate()}


class PythonGenerator(Generator):
    templates = {
        "python/casadi_reader/reader.py": "python/reader.py.in",
        "python/casadi_reader/__main__.py": "python/__main__.py.in",
        "python/casadi_reader/__init__.py": "python/__init__.py.in",
    }

    def generate(self):
        from codegen.python import Python

        return {
            **super().generate(),
            "python/casadi_reader/_generated.py": Python(self.data).generate(),
        }


class CGenerator(Generator):
    templates = {
        "c/src/reader.c": "c/reader.c.in",
        "c/src/main.c": "c/main.c.in",
        **{
            "c/src/" + name: "c/" + name + ".in"
            for name in ("state.h", "json.inc", "source.inc", "runtime.inc")
        },
        "c/include/casadi_reader/reader.h": "c/reader.h.in",
    }

    def generate(self):
        from codegen.c import C

        emitter = C(self.data)
        return {
            **super().generate(),
            "c/src/generated.inc": emitter.generate(),
            "c/src/metadata.h": emitter.metadata_source(),
        }


class CppGenerator(Generator):
    # Independent C++ structural reader and RAII interface.
    templates = {
        "cpp/src/reader.cpp": "cpp/reader.cpp.in",
        "cpp/src/main.cpp": "cpp/main.cpp.in",
        **{
            "cpp/src/" + name: "cpp/" + name + ".in"
            for name in ("json.hpp", "source.hpp", "runtime.hpp")
        },
        "cpp/include/casadi_reader/reader.h": "cpp/reader.h.in",
        "cpp/include/casadi_reader/reader.hpp": "cpp/reader.hpp.in",
    }

    def generate(self):
        from codegen.cpp import Cpp

        emitter = Cpp(self.data)
        return {
            **super().generate(),
            "cpp/src/generated.hpp": emitter.generate(),
            "cpp/src/metadata.hpp": emitter.metadata_source(),
        }


class MatlabGenerator(Generator):
    templates = {
        "matlab/+casadi_reader/Document.m": "matlab/+casadi_reader/Document.m.in",
        "matlab/+casadi_reader/read.m": "matlab/+casadi_reader/read.m.in",
    }

    def generate(self):
        from codegen.matlab import Matlab

        emitter = Matlab(self.data)
        outputs = super().generate()
        path = "matlab/+casadi_reader/Document.m"
        outputs[path] = outputs[path].replace(
            "@GENERATED_METHODS@",
            "\n".join(
                ("        " + line if line else "") for line in emitter.generate().splitlines()
            ),
        )
        outputs["matlab/+casadi_reader/metadata.m"] = emitter.metadata_source()
        return outputs


class JuliaGenerator(Generator):
    templates = {
        "julia/src/CasadiReader.jl": "julia/CasadiReader.jl.in",
        "julia/Project.toml": "julia/Project.toml.in",
    }

    def generate(self):
        from codegen.julia import Julia

        outputs = {**super().generate(), "julia/src/generated.jl": Julia(self.data).generate()}
        for name in ("LICENSE", "NOTICE"):
            outputs["julia/" + name] = (self.root / name).read_text()
        for path in (self.root / "LICENSES").glob("*.txt"):
            outputs["julia/LICENSES/" + path.name] = path.read_text()
        return outputs


GENERATORS = (
    JavaScriptGenerator,
    PythonGenerator,
    CGenerator,
    CppGenerator,
    MatlabGenerator,
    JuliaGenerator,
)
