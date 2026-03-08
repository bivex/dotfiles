#!/usr/bin/env python3
import argparse
import json
import os
import plistlib
from pathlib import Path

PLIST = os.path.expanduser("~/Library/Preferences/com.googlecode.iterm2.plist")


def main() -> int:
    repo_dir = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(description="Capture current iTerm profile into dotfiles")
    parser.add_argument("--profile", default="Dev")
    parser.add_argument("--output", default=str(repo_dir / "dev-profile.snapshot.json"))
    args = parser.parse_args()

    with open(PLIST, "rb") as fh:
        data = plistlib.load(fh)

    bookmarks = data.get("New Bookmarks", [])
    profile = next((p for p in bookmarks if p.get("Name") == args.profile), None)
    if profile is None:
        raise SystemExit(f"iTerm profile not found: {args.profile}")

    normalized = dict(profile)
    normalized.pop("Guid", None)

    payload = {
        "profile_name": args.profile,
        "profile": normalized,
    }

    output = Path(args.output).expanduser().resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(payload, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps({"profile": args.profile, "output": str(output)}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
