"""Build standalone release ZIPs and optional CI-built native binary ZIPs."""
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
parser.add_argument('--language', choices=['javascript', 'python', 'c', 'cpp', 'julia', 'matlab'])
parser.add_argument('--platform', help='Platform label for a native binary ZIP')
args = parser.parse_args()
args.output.mkdir(parents=True, exist_ok=True)


def notices(target):
    shutil.copytree(root / 'LICENSES', target / 'LICENSES', dirs_exist_ok=True)
    for name in ('LICENSE', 'NOTICE'):
        shutil.copy2(root / name, target / name)
    if not (target / 'README.md').exists():
        shutil.copy2(root / 'README.md', target / 'README.md')


def archive(directory):
    name = directory.name + ('-' + args.platform if args.platform else '') + '.zip'
    with zipfile.ZipFile(args.output / name, 'w', zipfile.ZIP_DEFLATED) as out:
        for path in sorted(directory.rglob('*')):
            if path.is_file():
                out.write(path, path.relative_to(directory.parent))


with tempfile.TemporaryDirectory() as temporary:
    stage = Path(temporary)
    if args.native_prefix:
        if args.language not in ('c', 'cpp') or not args.platform:
            parser.error('Native binaries require --language c|cpp and --platform')
        target = stage / ('casadi-reader-' + args.language)
        shutil.copytree(args.native_prefix, target)
        notices(target)
        archive(target)
    else:
        for language in ([args.language] if args.language else ['javascript', 'python', 'c', 'cpp', 'julia', 'matlab']):
            target = stage / ('casadi-reader-' + language)
            if language in ('c', 'cpp'):
                shutil.copytree(root / language, target / language)
                shutil.copytree(root / 'test/fixtures', target / 'test/fixtures')
                shutil.copy2(root / 'CMakeLists.txt', target / 'CMakeLists.txt')
            elif language == 'julia':
                shutil.copytree(root / 'julia', target,
                                ignore=shutil.ignore_patterns('Manifest.toml', 'deps', '__pycache__', '*.cov'))
            elif language == 'matlab':
                shutil.copytree(root / 'matlab', target)
            elif language == 'python':
                shutil.copytree(root / 'python/casadi_reader', target / 'casadi_reader',
                                ignore=shutil.ignore_patterns('__pycache__', '*.pyc'))
            elif language == 'javascript':
                if not (root / 'dist/index.js').is_file():
                    parser.error('Run npm run build before packaging JavaScript')
                (target / 'dist').mkdir(parents=True)
                shutil.copy2(root / 'dist/index.js', target / 'dist/index.js')
                shutil.copytree(root / 'bin', target / 'bin')
                metadata = json.loads((root / 'package.json').read_text())
                metadata.pop('devDependencies', None)
                metadata.pop('scripts', None)
                (target / 'package.json').write_text(json.dumps(metadata, indent=2) + '\n')
            notices(target)
            archive(target)
print('Standalone ZIPs written to', args.output)
