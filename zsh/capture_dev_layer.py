#!/usr/bin/env python3
import argparse
import json
from pathlib import Path


def main() -> int:
    repo_root = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(description="Sync ~/.zshrc.dev into dotfiles")
    parser.add_argument("--source", default=str(Path.home() / ".zshrc.dev"))
    parser.add_argument("--target", default=str(repo_root / ".zshrc.dev"))
    args = parser.parse_args()

    source = Path(args.source).expanduser().resolve()
    target = Path(args.target).expanduser().resolve()
    if not source.exists():
        raise SystemExit(f"Source file not found: {source}")

    content = source.read_text(encoding="utf-8")
    if content and not content.endswith("\n"):
        content += "\n"

    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(content, encoding="utf-8")
    print(json.dumps({"source": str(source), "target": str(target)}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
