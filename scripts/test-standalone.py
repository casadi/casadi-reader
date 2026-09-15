"""Exercise extracted ZIPs without installing the reader or runtime dependencies."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import zipfile

root = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('archives', type=Path)
parser.add_argument('--language', choices=['python', 'javascript', 'julia'], required=True)
args = parser.parse_args()
with tempfile.TemporaryDirectory() as directory:
    work = Path(directory)
    with zipfile.ZipFile(args.archives / ('casadi-reader-' + args.language + '.zip')) as archive:
        archive.extractall(work)
    package = work / ('casadi-reader-' + args.language)
    fixture = root / 'test/fixtures/arithmetic.casadi'
    env = dict(os.environ)
    if args.language == 'python':
        # -S disables site-packages; only the extracted package and stdlib are visible.
        env['PYTHONPATH'] = str(package)
        command = [sys.executable, '-S', '-m', 'casadi_reader', str(fixture)]
    elif args.language == 'javascript':
        command = ['node', str(package / 'bin/casadi-reader.js'), str(fixture)]
    else:
        # Empty depot: no registries, packages, manifests, or package-manager calls.
        env['JULIA_DEPOT_PATH'] = str(work / 'empty-depot')
        command = ['julia', '--startup-file=no', '--project=' + str(package), '-e',
                   'using CasadiReader; d=CasadiReader.read_casadi(ARGS[1]); '
                   'println(CasadiReader.encode_json(d))', str(fixture)]
    result = json.loads(subprocess.check_output(command, cwd=work, env=env))
    assert result['format'] == 'casadi_serialization'
    assert any(f['name'] == 'ProtoFunction::name' for f in result['objects'][result['root']]['fields'])
    print(args.language + ': standalone ZIP works without package installation')
