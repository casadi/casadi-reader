"""Regenerate native code from a changed scheme, then execute that code."""

import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]
LANGUAGES = os.environ.get("CASADI_READER_TEST_LANGUAGES", "javascript,python,c,cpp").split(",")


def encode(value):
    return "".join(chr(97 + (v & 15)) + chr(97 + (v >> 4)) for v in value)


class GenerationTests(unittest.TestCase):
    def test_scheme_extension(self):
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)
            scheme = json.loads((ROOT / "schemes/serialization_scheme.json").read_text())
            cases = scheme["reader"]["types"]["Function"]["body"][1]["body"][1]["cases"]
            cases["QXFunction"] = [
                {
                    "op": "repeat",
                    "count": ["literal", 1],
                    "body": [
                        {
                            "op": "if",
                            "condition": [
                                "equal",
                                ["field", "FunctionInternal::base_function"],
                                ["literal", "QXFunction"],
                            ],
                            "body": cases["MXFunction"],
                            "else": [{"op": "unsupported", "reason": "wrong generated branch"}],
                        }
                    ],
                }
            ]
            (out / "scheme.json").write_text(json.dumps(scheme))
            subprocess.check_call(
                [
                    sys.executable,
                    str(ROOT / "scripts/generate-reader-assets.py"),
                    "--scheme",
                    str(out / "scheme.json"),
                    "--output-root",
                    str(out),
                ]
            )
            (out / "package.json").write_text('{"type":"module"}')
            for language, compiler, standard, extension in (
                ("c", "cc", "c99", "c"),
                ("cpp", "c++", "c++11", "cpp"),
            ):
                if language in LANGUAGES:
                    subprocess.check_call(
                        [
                            compiler,
                            "-std=" + standard,
                            "-I" + str(out / language / "include"),
                            str(out / language / ("src/reader." + extension)),
                            str(out / language / ("src/main." + extension)),
                            "-o",
                            str(out / ("reader-" + language)),
                        ]
                    )
            for fixture in ("arithmetic", "arithmetic.debug"):
                original = (ROOT / "test/fixtures" / (fixture + ".casadi")).read_text()
                text = original.replace(encode(b"MXFunction"), encode(b"QXFunction"), 1)
                (out / "input.casadi").write_text(text)
                # The established structural document changes only its discriminator.
                from casadi_reader import loads

                # Layout names remain MXFunction: only the serialized field changes.
                expected = loads(original)
                for record in expected["objects"]:
                    for field in record["fields"]:
                        if (
                            field["name"] == "FunctionInternal::base_function"
                            and field["value"] == "MXFunction"
                        ):
                            field["value"] = "QXFunction"
                for language in LANGUAGES:
                    with self.subTest(language=language, fixture=fixture):
                        if language == "javascript":
                            command = [
                                "node",
                                "--input-type=module",
                                "-e",
                                "import{decode}from'./src/index.js';import{readFileSync}from'node:fs';"
                                "console.log(JSON.stringify(decode(readFileSync('input.casadi','utf8'))));",
                            ]
                        elif language == "python":
                            command = [sys.executable, "-m", "casadi_reader", "input.casadi"]
                        elif language in ("c", "cpp"):
                            command = [str(out / ("reader-" + language)), "input.casadi"]
                        elif language == "julia":
                            command = [
                                "julia",
                                "--project=" + str(ROOT / "julia"),
                                "-e",
                                'include("julia/src/CasadiReader.jl"); '
                                'println(CasadiReader.encode_json(CasadiReader.read_casadi("input.casadi")))',
                            ]
                        elif language == "matlab":
                            subprocess.check_call(
                                [
                                    "matlab",
                                    "-batch",
                                    "addpath('matlab'); d=casadi_reader.Document('input.casadi'); "
                                    "f=fopen('output.json','w'); fwrite(f,d.json()); fclose(f);",
                                ],
                                cwd=out,
                            )
                            self.assertEqual(
                                json.loads((out / "output.json").read_text()), expected
                            )
                            continue
                        else:
                            self.fail("Unknown test language: " + language)
                        result = subprocess.check_output(
                            command, cwd=out, env=dict(os.environ, PYTHONPATH=str(out / "python"))
                        )
                        self.assertEqual(json.loads(result), expected)

    def test_generated_code_is_linear_and_has_no_instruction_tables(self):
        sys.path.insert(0, str(ROOT / "scripts"))
        from reader_generators import GENERATORS

        scheme = json.loads((ROOT / "schemes/serialization_scheme.json").read_text())
        size = len(json.dumps(scheme["reader"], indent=2))
        for backend in GENERATORS:
            with self.subTest(language=backend.__name__):
                outputs = backend(ROOT, scheme).generate()
                source = "\n".join(outputs.values())
                self.assertLess(len(source), 4 * size)
                for obsolete in (
                    "scheme_json",
                    "type_expression",
                    "Unknown scheme operand",
                    "program(step",
                    "program(def",
                    'step.at("body")',
                ):
                    self.assertNotIn(obsolete, source)


if __name__ == "__main__":
    unittest.main()
