import json
import os
from pathlib import Path
import shutil
import struct
import subprocess
import tempfile
import unittest

from casadi_reader import loads, loads_resource, read_casadi, read_resource, to_json
from casadi_reader.reader import Source, _resource

ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT/'test/fixtures'
NAMES = ('arithmetic', 'mapping', 'slice', 'assignment', 'sparse')


class ReaderTests(unittest.TestCase):
    def test_native_oracles(self):
        for name in NAMES:
            with self.subTest(name=name):
                document = read_casadi(FIXTURES/(name+'.casadi'))
                self.assertEqual(document, read_casadi(FIXTURES/(name+'.casadi'), lazy=True))
                oracle = json.loads((FIXTURES/(name+'.json')).read_text())
                info = json.loads((FIXTURES/(name+'.info.json')).read_text())
                objects = document['objects']
                f = objects[document['root']]
                self.assertEqual(f['name'], oracle['name'])
                self.assertEqual(f['type'], oracle['type'])
                self.assertEqual(len(f['instructions']), len(oracle['nodes']))
                for ports, refs in [('ins', 'inputs'), ('outs', 'outputs')]:
                    self.assertEqual([{k: v for k, v in objects[i].items() if k != 'kind'}
                                      for i in f[ports]], [p['sparsity'] for p in oracle[refs]])
                for i, instruction in enumerate(f['instructions']):
                    node = objects[instruction['node']]
                    self.assertEqual(node['op'], oracle['nodes'][i]['op'])
                    self.assertEqual(node['info'], info[i])
                    if 'mapping' in oracle['nodes'][i]:
                        self.assertEqual(node['mapping'], oracle['nodes'][i]['mapping'])

    @unittest.skipUnless(shutil.which('node') and (ROOT/'bin/casadi-reader.js').is_file(),
                         'JavaScript implementation or Node not installed')
    def test_javascript_agreement(self):
        for name in NAMES:
            expected = json.loads(subprocess.check_output(
                ['node', 'bin/casadi-reader.js', str(FIXTURES/(name+'.casadi'))], cwd=ROOT))
            self.assertEqual(read_casadi(FIXTURES/(name+'.casadi')), expected)

    @unittest.skipUnless(os.environ.get('CASADI_READER_NATIVE'), 'Native CLI not configured')
    def test_native_agreement(self):
        for name in NAMES:
            path = FIXTURES/(name+'.casadi')
            output = subprocess.check_output([os.environ['CASADI_READER_NATIVE'], str(path)])
            self.assertEqual(json.loads(output), read_casadi(path))
        path = FIXTURES/'resource.casadi'
        for lazy in (False, True):
            command = [os.environ['CASADI_READER_NATIVE'], '--resource']
            if lazy:
                command.append('--lazy')
            output = subprocess.check_output(command+[str(path)])
            self.assertEqual(json.loads(output), json.loads(to_json(read_resource(path, lazy=lazy))))

    @unittest.skipUnless(os.environ.get('CASADI_READER_NATIVE'), 'Native CLI not configured')
    def test_native_rejects_bad_files(self):
        text = (FIXTURES/'mapping.casadi').read_text()
        bad_files = ['', text+'aa', text[:32]+'ba'+text[34:], text[:16]+'e'+text[17:]]
        bad_files += [text[:i] for i in range(0, len(text), 64)]
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)/'bad.casadi'
            for bad in bad_files:
                path.write_text(bad)
                run = subprocess.run([os.environ['CASADI_READER_NATIVE'], str(path)],
                                     capture_output=True)
                self.assertEqual(run.returncode, 1, run.stderr)
                self.assertTrue(run.stderr)

    def test_native_resource(self):
        expected = (FIXTURES/'payload.zip').read_bytes()
        self.assertEqual(read_resource(FIXTURES/'resource.casadi')['resource']['blob'], expected)
        blob = read_resource(FIXTURES/'resource.casadi', lazy=True)['resource']['blob']
        try:
            self.assertEqual(blob.read(), expected)
            self.assertEqual(blob.read(5, 7), expected[5:12])
            with self.assertRaises(ValueError):
                blob.read(len(expected)-1, 2)
            self.assertEqual(json.loads(to_json(blob))['byteLength'], len(expected))
        finally:
            blob.close()
        with self.assertRaises(ValueError):
            blob.read(0, 1)

    def test_large_lazy_file(self):
        text = (FIXTURES/'resource.casadi').read_text()
        blob = loads_resource(text, lazy=True)['resource']['blob']
        offset = blob.offset
        size = 16*1024*1024
        encoded_size = ''.join(chr(97+(b & 15))+chr(97+(b >> 4)) for b in struct.pack('<Q', size))
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)/'large.casadi'
            with path.open('w') as stream:
                stream.write(text[:2*(offset-8)]+encoded_size)
                for _ in range(16):
                    stream.write('ab'*(1024*1024))
            source = Source(path=path)
            try:
                document = _resource(source, lazy=True)
                self.assertLess(source.decoded_bytes, 256)
                before = source.decoded_bytes
                self.assertEqual(document['resource']['blob'].read(size-3, 3), b'\x10'*3)
                self.assertEqual(source.decoded_bytes-before, 3)
            finally:
                source.close()

    def test_bad_inputs(self):
        text = (FIXTURES/'mapping.casadi').read_text()
        for bad in ['', text[:-2], text+'aa', text+'z', 'a', text[1:]]:
            with self.subTest(length=len(bad)), self.assertRaises(ValueError):
                loads(bad)
        with self.assertRaisesRegex(ValueError, 'protocol'):
            loads(text[:16]+'e'+text[17:])
        with self.assertRaisesRegex(ValueError, 'Debug'):
            loads(text[:32]+'ba'+text[34:])

    def test_vendored_scheme(self):
        from casadi_reader import reader
        self.assertEqual(Path(reader.__file__).with_name('serialization_scheme.json').read_bytes(),
                         (ROOT/'schemes/serialization_scheme.json').read_bytes())


if __name__ == '__main__':
    unittest.main()
