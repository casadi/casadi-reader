"""All published bindings must describe the same release."""
import json
import os
from pathlib import Path
import re
import tomllib

root = Path(__file__).resolve().parents[1]
version = json.loads((root/'package.json').read_text())['version']
assert tomllib.loads((root/'pyproject.toml').read_text())['project']['version'] == version
assert tomllib.loads((root/'julia/Project.toml').read_text())['version'] == version
assert re.search(r'project\(casadi_reader VERSION ([^ ]+)', (root/'CMakeLists.txt').read_text())[1] == version
lock = json.loads((root/'package-lock.json').read_text())
assert lock['version'] == lock['packages']['']['version'] == version
if os.environ.get('RELEASE_TAG'):
    assert os.environ['RELEASE_TAG'] == 'v'+version
print('All binding versions match', version)
