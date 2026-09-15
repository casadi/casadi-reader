"""Package independent language implementations and optional CI-built binaries."""
import argparse
import json
from pathlib import Path
import shutil
import tempfile
import zipfile

root = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path, required=True)
parser.add_argument('--native-prefix', type=Path)
parser.add_argument('--language', choices=['c', 'cpp'])
parser.add_argument('--platform', help='Platform label for a native binary archive')
args = parser.parse_args()
version = json.loads((root/'package.json').read_text())['version']
args.output.mkdir(parents=True, exist_ok=True)


def notices(target):
    shutil.copytree(root/'LICENSES', target/'LICENSES')
    for name in ('LICENSE', 'NOTICE', 'README.md'):
        shutil.copy2(root/name, target/name)


def archive(directory, zip=False):
    name=directory.name+'-'+version
    if args.platform: name+='-'+args.platform
    if zip:
        with zipfile.ZipFile(args.output/(name+'.zip'), 'w', zipfile.ZIP_DEFLATED) as out:
            for path in sorted(directory.rglob('*')):
                if path.is_file(): out.write(path, path.relative_to(directory.parent))
    else:
        shutil.make_archive(str(args.output/name), 'gztar', directory.parent, directory.name)


with tempfile.TemporaryDirectory() as temporary:
    stage = Path(temporary)
    if args.native_prefix:
        if not args.language or not args.platform: parser.error('Native binaries require --language and --platform')
        target=stage/('casadi-reader-'+args.language)
        shutil.copytree(args.native_prefix, target)
        notices(target)
        archive(target)
    else:
        for language,directory in [('c','c'),('cpp','cpp')]:
            target=stage/('casadi-reader-'+language+'-source')
            shutil.copytree(root/directory, target/directory)
            shutil.copytree(root/'test/fixtures', target/'test/fixtures')
            shutil.copy2(root/'CMakeLists.txt', target/'CMakeLists.txt')
            notices(target); archive(target)
        julia=stage/'CasadiReader'
        shutil.copytree(root/'julia', julia, ignore=shutil.ignore_patterns('Manifest.toml','deps','__pycache__'))
        notices(julia); archive(julia)
        matlab=stage/'casadi-reader-matlab'
        shutil.copytree(root/'matlab', matlab, ignore=shutil.ignore_patterns('*.mex*','casadi_reader_mex.cpp'))
        notices(matlab); archive(matlab, zip=True)
print('Packages written to', args.output)
