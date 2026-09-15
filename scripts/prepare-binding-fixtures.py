"""Prepare shared plain/debug fixtures with Python structural JSON oracles."""
import json
from pathlib import Path
import shutil
import sys
from casadi_reader import read_casadi

root = Path(__file__).resolve().parents[1]
out = Path(sys.argv[1])
shutil.copytree(root/'test/fixtures', out, dirs_exist_ok=True)
for path in out.glob('*.casadi'):
    options = {'type': 'Resource'} if path.stem == 'resource' else {}
    path.with_suffix('.reader.json').write_text(json.dumps(read_casadi(path, **options)))
