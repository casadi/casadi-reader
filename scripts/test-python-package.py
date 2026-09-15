"""Test both a wheel and a wheel rebuilt from the sdist, outside the source tree."""
import argparse
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import venv

root=Path(__file__).resolve().parents[1]
parser=argparse.ArgumentParser()
parser.add_argument('distributions',type=Path)
args=parser.parse_args()
with tempfile.TemporaryDirectory() as temporary:
    work=Path(temporary)
    venv.EnvBuilder(with_pip=True).create(work/'env')
    python=work/'env'/('Scripts/python.exe' if os.name=='nt' else 'bin/python')
    subprocess.run([str(python),'-m','pip','install','build'],check=True)
    for distribution in [next(args.distributions.glob('*.whl')),next(args.distributions.glob('*.tar.gz'))]:
        subprocess.run([str(python),'-m','pip','install','--force-reinstall',str(distribution.resolve())],check=True,cwd=work)
        subprocess.run([str(python),'-m','unittest','discover','-s',str(root/'python/tests'),'-p','test_reader.py'],check=True,cwd=work)
        subprocess.run([str(python),'-m','casadi_reader',str(root/'test/fixtures/arithmetic.casadi')],check=True,cwd=work,stdout=subprocess.DEVNULL)
