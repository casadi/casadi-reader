import argparse
from pathlib import Path
from . import read_casadi, read_resource, to_json


def main():
    parser = argparse.ArgumentParser(description="Inspect CasADi files without CasADi")
    parser.add_argument("input", type=Path)
    parser.add_argument("output", type=Path, nargs="?")
    parser.add_argument("--lazy", action="store_true")
    parser.add_argument("--resource", action="store_true", help="Read a raw Resource stream")
    args = parser.parse_args()
    try:
        read = read_resource if args.resource else read_casadi
        text = to_json(read(args.input, lazy=args.lazy), indent=2) + "\n"
        if args.output:
            args.output.write_text(text)
        else:
            print(text, end="")
    except (OSError, ValueError) as error:
        parser.exit(1, str(error) + "\n")


if __name__ == "__main__":
    main()
