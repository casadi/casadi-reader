"""Commit a reproducible generated snapshot to main using a fast-forward push."""
import argparse
import importlib.util
import json
from pathlib import Path
import shutil
import subprocess
import tempfile

root = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--push', action='store_true')
parser.add_argument('--output-root', type=Path, help='Prepare a snapshot without committing or pushing')
args = parser.parse_args()


def git(*args, cwd=root):
    return subprocess.check_output(['git', *args], cwd=cwd, text=True).strip()


spec = importlib.util.spec_from_file_location('generate_assets', root / 'scripts/generate-reader-assets.py')
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)
outputs = module.generate(root)
source = git('rev-parse', 'HEAD')


def snapshot(destination):
    for name in git('ls-files', '-z').split('\0'):
        if not name:
            continue
        target = destination / name
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(root / name, target)
    for name, text in outputs.items():
        target = destination / name
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(text)
    (destination / 'dist').mkdir(exist_ok=True)
    shutil.copy2(root / 'dist/index.js', destination / 'dist/index.js')
    metadata = {'sourceBranch': 'generate', 'sourceCommit': source,
                'sourceUrl': 'https://github.com/casadi/casadi-reader/tree/' + source}
    (destination / 'generation.json').write_text(json.dumps(metadata, indent=2) + '\n')


if args.output_root:
    args.output_root.mkdir(parents=True, exist_ok=True)
    snapshot(args.output_root)
else:
    git('fetch', 'origin', 'main')
    with tempfile.TemporaryDirectory() as temporary:
        work = Path(temporary) / 'main'
        git('worktree', 'add', '--detach', str(work), 'origin/main')
        try:
            git('rm', '-r', '--quiet', '--ignore-unmatch', '.', cwd=work)
            snapshot(work)
            git('add', '--all', '--force', cwd=work)
            changed = subprocess.run(['git', 'diff', '--cached', '--quiet'], cwd=work).returncode
            if changed:
                git('-c', 'user.name=github-actions[bot]', '-c',
                    'user.email=41898282+github-actions[bot]@users.noreply.github.com',
                    'commit', '-m', 'Generate readers from ' + source[:12], cwd=work)
                print('Generated commit:', git('rev-parse', 'HEAD', cwd=work))
                if args.push:
                    git('push', 'origin', 'HEAD:refs/heads/main', cwd=work)
            else:
                print('main already contains this generated snapshot')
        finally:
            git('worktree', 'remove', '--force', str(work))
