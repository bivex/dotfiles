#!/usr/bin/env python3
import argparse
import json
import os
import plistlib
from pathlib import Path

PLIST = os.path.expanduser("~/Library/Preferences/com.apple.Terminal.plist")


def main() -> int:
    repo_dir = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(description="Capture current Terminal.app profile into dotfiles")
    parser.add_argument("--profile", default="Dev")
    parser.add_argument("--output", default=str(repo_dir / "dev-profile.snapshot.plist"))
    args = parser.parse_args()

    with open(PLIST, "rb") as fh:
        data = plistlib.load(fh)

    settings = data.get("Window Settings") or {}
    profile = settings.get(args.profile)
    if profile is None:
        raise SystemExit(f"Terminal profile not found: {args.profile}")

    payload = {
        "Default Window Settings": args.profile,
        "Startup Window Settings": args.profile,
        "SecureKeyboardEntry": data.get("SecureKeyboardEntry", True),
        "Window Settings": {args.profile: profile},
    }

    output = Path(args.output).expanduser().resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    with open(output, "wb") as fh:
        plistlib.dump(payload, fh, fmt=plistlib.FMT_XML, sort_keys=True)
    print(json.dumps({"profile": args.profile, "output": str(output)}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
