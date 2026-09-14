"""Create Julia, MATLAB and native source packages; does not publish anything."""
import argparse
from pathlib import Path
import shutil
import tempfile
import zipfile

root = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--output', type=Path, required=True)
parser.add_argument('--mex', type=Path, help='Built MEX to include in the MATLAB ZIP')
args = parser.parse_args()
args.output.mkdir(parents=True, exist_ok=True)


def native(target):
    shutil.copytree(root/'native', target/'native')
    shutil.copytree(root/'matlab', target/'matlab')
    shutil.copytree(root/'test/fixtures', target/'test/fixtures')
    for name in ('CMakeLists.txt', 'LICENSE', 'README.md'):
        shutil.copy2(root/name, target/name)


with tempfile.TemporaryDirectory() as temporary:
    stage = Path(temporary)
    julia = stage/'CasadiReader'
    shutil.copytree(root/'julia', julia,
                    ignore=shutil.ignore_patterns('Manifest.toml', 'usr', 'build'))
    native(julia/'deps/reader')
    for name in ('LICENSE', 'README.md'):
        shutil.copy2(root/name, julia/name)
    shutil.make_archive(str(args.output/'CasadiReader-0.0.0'), 'gztar', stage, 'CasadiReader')
    cpp = stage/'casadi-reader-native'
    cpp.mkdir()
    native(cpp)
    shutil.make_archive(str(args.output/'casadi-reader-native-0.0.0'), 'gztar', stage, cpp.name)
    matlab = stage/'casadi-reader-matlab'
    shutil.copytree(root/'matlab', matlab)
    for name in ('LICENSE', 'README.md'):
        shutil.copy2(root/name, matlab/name)
    if args.mex:
        shutil.copy2(args.mex, matlab/args.mex.name)
    with zipfile.ZipFile(args.output/'casadi-reader-matlab-0.0.0.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
        for path in sorted(matlab.rglob('*')):
            if path.is_file():
                archive.write(path, path.relative_to(stage))
print('Packages written to', args.output)
