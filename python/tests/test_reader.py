import hashlib
import json
import os
from pathlib import Path
import shutil
import struct
import subprocess
import tempfile
import unittest
from casadi_reader import loads, loads_resource, read_casadi, read_resource, to_json
from casadi_reader.reader import Source, Reader
from casadi_reader._generated import METADATA

ROOT = Path(__file__).resolve().parents[2]
FIXTURES = ROOT/'test/fixtures'
PATHS = sorted(FIXTURES.glob('*.casadi'))
NATIVE = os.environ.get('CASADI_READER_NATIVE')


def blob(document):
    return next(f['value'] for f in document['objects'][document['root']]['fields']
                if f['name'] == 'ZipMemResource::blob')


def encode(data):
    return ''.join(chr(97+(b&15))+chr(97+(b>>4)) for b in data)


class ReaderTests(unittest.TestCase):
    @unittest.skipUnless(shutil.which('node'), 'Node not installed')
    def test_all_languages_agree_on_every_field(self):
        for path in PATHS:
            options = {'type': 'Resource'} if path.stem == 'resource' else {}
            for lazy in (False, True):
                with self.subTest(path=path.name, lazy=lazy):
                    expected = json.loads(subprocess.check_output(['node', '--input-type=module', '-e',
                        "import{decode}from'./src/index.js';import{readFileSync}from'node:fs';"
                        "console.log(JSON.stringify(decode(readFileSync(process.argv[1],'utf8'),JSON.parse(process.argv[2]))));",
                        str(path), json.dumps(dict(options, lazy=lazy))], cwd=ROOT))
                    got = json.loads(to_json(read_casadi(path, lazy=lazy, **options)))
                    self.assertEqual(got, expected)
                    if NATIVE:
                        args = [NATIVE]+(['--resource'] if options else [])+(['--lazy'] if lazy else [])
                        self.assertEqual(json.loads(subprocess.check_output(args+[str(path)])), expected)

    def test_matches_precompiler_structural_documents(self):
        # Digests of the interpreter's complete documents, recorded before direct code generation.
        digests = json.loads((FIXTURES/'structural-digests.json').read_text())
        self.assertEqual(set(digests), {path.name for path in PATHS})
        for path in PATHS:
            with self.subTest(fixture=path.name):
                options = {'type': 'Resource'} if path.stem == 'resource' else {}
                data = read_casadi(path, **options)
                canonical = json.dumps(data, sort_keys=True, separators=(',', ':')).encode()
                self.assertEqual(hashlib.sha256(canonical).hexdigest(), digests[path.name])

    def test_unknown_discriminator(self):
        text = (FIXTURES/'arithmetic.casadi').read_text()
        text = text.replace(encode(b'MXFunction'), encode(b'QXFunction'))
        with self.assertRaisesRegex(ValueError, 'discriminator'):
            loads(text)

    def test_lazy_resource_lifetime_and_bounds(self):
        expected = (FIXTURES/'payload.zip').read_bytes()
        self.assertEqual(blob(read_resource(FIXTURES/'resource.casadi'))['$bytes'], list(expected))
        deferred = blob(read_resource(FIXTURES/'resource.casadi', lazy=True))
        self.assertEqual(deferred.read(), expected)
        self.assertEqual(deferred.read(5, 7), expected[5:12])
        with self.assertRaises(ValueError): deferred.read(len(expected)-1, 2)
        deferred.close()
        with self.assertRaises(ValueError): deferred.read(0, 1)

    def test_large_payload_remains_lazy(self):
        text = (FIXTURES/'resource.casadi').read_text()
        offset = blob(loads_resource(text, lazy=True)).offset
        size = 2*1024*1024
        text = text[:2*(offset-8)]+encode(struct.pack('<Q', size))+'ab'*size
        source = Source(text=text)
        document = Reader(source, lazy=True).decode('Resource')
        self.assertLess(source.decoded_bytes, 65536)
        self.assertEqual(blob(document).read(size-3, 3), bytes([16]*3))

    def test_typed_primitives_and_multiple_roots(self):
        header = struct.pack('<qqB', METADATA['wire']['magic'], METADATA['wire']['protocol'], 0)
        cases = [('casadi_int', struct.pack('<q', -(2**63)), {'$integer': str(-(2**63))}),
                 ('size_t', struct.pack('<Q', 2**64-1), {'$integer': str(2**64-1)}),
                 ('double', struct.pack('<d', float('inf')), {'$float': 'Infinity'}),
                 ('std::string', struct.pack('<i', 2)+b'\xff\x00', {'$bytes': [255, 0]})]
        for kind, payload, value in cases:
            text = encode(header+payload)
            self.assertEqual(loads(text, type=kind)['roots'], [value])
            if NATIVE:
                with tempfile.TemporaryDirectory() as directory:
                    path = Path(directory)/'primitive.casadi'; path.write_text(text)
                    result = json.loads(subprocess.check_output([NATIVE, '--type', kind, str(path)]))
                    self.assertEqual(result, loads(text, type=kind))
        # FileSerializer doubles have no shared references and can be concatenated.
        tag = next(int(k) for k,v in METADATA['reader']['file_types'].items() if v=='double')
        text = encode(header+bytes([tag])+struct.pack('<d', 2.5)+bytes([tag])+struct.pack('<d', -4))
        self.assertEqual(loads(text)['roots'], [2.5, -4])
        self.assertIsNone(loads(text)['root'])

    def test_malformed_input(self):
        text = (FIXTURES/'mapping.casadi').read_text()
        bad = ['', text+'aa', text+'z', 'a', text[:16]+'e'+text[17:]]
        bad += [text[:i] for i in range(0, len(text), 128)]
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory)/'bad.casadi'
            for payload in bad:
                with self.assertRaises(ValueError): loads(payload)
                if NATIVE:
                    path.write_text(payload)
                    run = subprocess.run([NATIVE,str(path)],capture_output=True)
                    self.assertEqual(run.returncode,1,run.stderr)
                    self.assertTrue(run.stderr)


if __name__ == '__main__': unittest.main()
