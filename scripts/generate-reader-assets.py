"""Generate every language reader from the vendored scheme and runtime templates."""

import argparse
import json
from pathlib import Path
from reader_generators import GENERATORS


def generate(root, scheme_path=None):
    scheme = json.loads((scheme_path or root / "schemes/serialization_scheme.json").read_text())
    if scheme["format"] != "casadi_serialization_scheme" or scheme["version"] != 1:
        raise ValueError("Unsupported serialization scheme")
    if scheme["reader"]["version"] != 1:
        raise ValueError("Unsupported reader layout version")
    return {
        path: text
        for backend in GENERATORS
        for path, text in backend(root, scheme).generate().items()
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true")
    parser.add_argument("--scheme", type=Path, help="Input serialization scheme JSON")
    parser.add_argument("--output-root", type=Path, help="Destination for generated readers")
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    stale = []
    for relative, text in generate(root, args.scheme).items():
        output = (args.output_root or root) / relative
        if args.check:
            if not output.exists() or output.read_text() != text:
                stale.append(relative)
        else:
            output.parent.mkdir(parents=True, exist_ok=True)
            output.write_text(text)
    if stale:
        parser.exit(1, "Stale reader assets: " + ", ".join(stale) + "; run npm run generate\n")


if __name__ == "__main__":
    main()
