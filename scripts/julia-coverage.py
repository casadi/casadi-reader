"""Merge Julia .cov files into LCOV and report uncovered executable lines.

No generated code or commercial-plugin lines are excluded from the totals.
Use --clean before Pkg.test(coverage=true) to discard old counters.
"""
import argparse
import json
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--source", type=Path, default=ROOT / "julia/src")
parser.add_argument("--output", type=Path, default=ROOT / "coverage/julia.lcov")
parser.add_argument("--clean", action="store_true")
parser.add_argument("--details", action="store_true")
parser.add_argument("--minimum", type=float, default=0, help="Minimum overall line coverage")
parser.add_argument("--runtime-minimum", type=float, default=0, help="Minimum runtime line coverage")
args = parser.parse_args()
if args.clean:
    for source in args.source.glob("*.jl"):
        for cov in source.parent.glob(source.name + "*.cov"):
            cov.unlink()
    raise SystemExit(0)
args.output.parent.mkdir(parents=True, exist_ok=True)
lcov, details, summary, failures = [], [], [], []
total = covered = 0
for source in sorted(args.source.glob("*.jl")):
    counts = {}
    code = source.read_text().splitlines()
    for cov in sorted(source.parent.glob(source.name + "*.cov")):
        rows = cov.read_text().splitlines()
        if len(rows) != len(code):
            raise SystemExit(f"Stale coverage: {cov}; clean counters and rerun tests")
        for number, row in enumerate(rows, 1):
            count = row[:9].strip()
            if count.isdigit():
                counts[number] = counts.get(number, 0) + int(count)
    if not counts:
        raise SystemExit(f"Missing coverage for {source}; run Pkg.test(coverage=true)")
    hit = sum(n > 0 for n in counts.values())
    total += len(counts)
    covered += hit
    # Tests may run from a standalone ZIP; report against the canonical repo paths.
    name = str(Path("julia/src") / source.name)
    percent = 100 * hit / len(counts)
    print(f"{name}: {hit}/{len(counts)} lines ({percent:.2f}%)")
    missing = [number for number, count in sorted(counts.items()) if not count]
    summary.append({"file": name, "covered": hit, "total": len(counts), "percent": percent,
                    "uncovered": missing})
    if source.name == "CasADiReader.jl" and percent < args.runtime_minimum:
        failures.append(f"Runtime coverage below {args.runtime_minimum}%")
    lcov += ["TN:", f"SF:{name}"]
    lcov += [f"DA:{number},{count}" for number, count in sorted(counts.items())]
    lcov += [f"LF:{len(counts)}", f"LH:{hit}", "end_of_record"]
    function = ""
    for number, line in enumerate(code, 1):
        if line.startswith("function "):
            function = line.split("(", 1)[0][9:]
        if counts.get(number) == 0:
            details.append(f"{name}:{number}: {function}: {line.strip()}")
if not total:
    raise SystemExit("No Julia source files found")
percent = 100 * covered / total
print(f"Total: {covered}/{total} lines ({percent:.2f}%)")
args.output.write_text("\n".join(lcov) + "\n")
args.output.with_suffix(".json").write_text(json.dumps({"covered": covered, "total": total,
    "percent": percent, "files": summary}, indent=2) + "\n")
args.output.with_suffix(".uncovered.txt").write_text("\n".join(details) + "\n")
if args.details:
    print("\n".join(details))
if os.environ.get("GITHUB_STEP_SUMMARY"):
    with open(os.environ["GITHUB_STEP_SUMMARY"], "a") as out:
        out.write("\nJulia line coverage (including generated code and unavailable plugins):\n\n")
        out.write("| File | Covered / total | Coverage |\n| --- | --- | --- |\n")
        for row in summary:
            out.write(f"| {row['file']} | {row['covered']} / {row['total']} | {row['percent']:.2f}% |\n")
if percent < args.minimum:
    failures.append(f"Overall coverage below {args.minimum}%")
if failures:
    raise SystemExit("; ".join(failures))
