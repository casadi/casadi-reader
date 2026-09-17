"""Require the exact tagged Julia source tree to be registered in General."""
from pathlib import Path
import subprocess
import tomllib
from urllib.request import urlopen


def check(root, fetch):
    project = tomllib.loads((root / 'julia/Project.toml').read_text())
    name, version = project['name'], project['version']
    prefix = f'{name[0]}/{name}/'
    package = tomllib.loads(fetch(prefix + 'Package.toml'))
    versions = tomllib.loads(fetch(prefix + 'Versions.toml'))
    if (package.get('name') != name or package.get('uuid') != project['uuid']
            or package.get('repo') != 'https://github.com/casadi/casadi-reader.git'
            or package.get('subdir') != 'julia'):
        raise ValueError('General package identity does not match this repository')
    registered = versions.get(version, {})
    tree = subprocess.check_output(
        ['git', 'rev-parse', 'HEAD:julia'], cwd=root, text=True).strip()
    if registered.get('git-tree-sha1') != tree or registered.get('yanked', False):
        raise ValueError(f'{name} {version}: tagged Julia tree is not registered in General')
    print(f'General confirms {name} {version}, Julia tree {tree}')


def fetch_general(path):
    url = 'https://raw.githubusercontent.com/JuliaRegistries/General/master/' + path
    with urlopen(url, timeout=30) as response:
        return response.read().decode('utf-8')


if __name__ == '__main__':
    check(Path(__file__).resolve().parents[1], fetch_general)
