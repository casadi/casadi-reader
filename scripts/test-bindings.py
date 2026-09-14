"""Compare every graph field in the native bindings with the Python reader."""
import argparse
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

root = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(root/'python'))
from casadi_reader import read_casadi

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--matlab-mex-dir', type=Path)
parser.add_argument('--julia-project', type=Path)
args = parser.parse_args()
if not args.matlab_mex_dir and not args.julia_project:
    parser.error('Select at least one binding')
with tempfile.TemporaryDirectory(prefix='casadi-reader-bindings-') as temporary:
    fixtures = Path(temporary)/'fixtures'
    shutil.copytree(root/'test/fixtures', fixtures)
    for name in ('arithmetic', 'mapping', 'slice', 'assignment', 'sparse'):
        (fixtures/(name+'.reader.json')).write_text(json.dumps(read_casadi(fixtures/(name+'.casadi'))))
    if args.matlab_mex_dir:
        quote = lambda path: "'"+str(path).replace("'", "''")+"'"
        command = ('addpath('+quote(root/'matlab')+'); addpath('+quote(args.matlab_mex_dir.resolve())+
                   '); test_reader('+quote(fixtures)+')')
        subprocess.run(['matlab', '-batch', command], check=True)
    if args.julia_project:
        env = dict(os.environ, CASADI_READER_FIXTURES=str(fixtures))
        subprocess.run(['julia', '--project='+str(args.julia_project.resolve()),
                        str(root/'julia/test/runtests.jl')], env=env, check=True)
