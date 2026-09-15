"""A scheme-only extension must reach separately generated reader runtimes."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]


def encode(value):
    return ''.join(chr(97+(v & 15))+chr(97+(v >> 4)) for v in value)


class GenerationTests(unittest.TestCase):
    def test_scheme_extension(self):
        with tempfile.TemporaryDirectory() as directory:
            out = Path(directory)
            scheme = json.loads((ROOT/'schemes/serialization_scheme.json').read_text())
            cases = scheme['reader']['types']['Function']['body'][1]['body'][1]['cases']
            cases['QXFunction'] = cases['MXFunction']
            (out/'scheme.json').write_text(json.dumps(scheme))
            subprocess.check_call(['python3', str(ROOT/'scripts/generate-reader-assets.py'),
                                   '--scheme', str(out/'scheme.json'), '--output-root', str(out)])
            text = (ROOT/'test/fixtures/arithmetic.casadi').read_text()
            (out/'input.casadi').write_text(text.replace(encode(b'MXFunction'), encode(b'QXFunction')))
            (out/'package.json').write_text('{"type":"module"}')
            js = subprocess.check_output(['node', '--input-type=module', '-e',
                "import{decode}from'./src/index.js';import{readFileSync}from'node:fs';"
                "console.log(JSON.stringify(decode(readFileSync('input.casadi','utf8'))));"], cwd=out)
            py = subprocess.check_output(['python3', '-m', 'casadi_reader', 'input.casadi'],
                cwd=out, env=dict(os.environ, PYTHONPATH=str(out/'python')))
            subprocess.check_call(['c++', '-std=c++11', '-I'+str(out/'native/include'),
                str(out/'native/src/reader.cpp'), str(out/'native/src/main.cpp'),
                '-o', str(out/'reader')])
            native = subprocess.check_output([str(out/'reader'), str(out/'input.casadi')])
            self.assertEqual(json.loads(js), json.loads(py))
            self.assertEqual(json.loads(js), json.loads(native))
            self.assertIn('QXFunction', js.decode())


if __name__ == '__main__':
    unittest.main()
