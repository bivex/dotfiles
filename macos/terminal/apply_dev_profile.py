#!/usr/bin/env python3
import argparse
import json
import os
import plistlib
import shutil
import time
from copy import deepcopy

PLIST = os.path.expanduser("~/Library/Preferences/com.apple.Terminal.plist")


def main() -> int:
    parser = argparse.ArgumentParser(description="Create/update Terminal.app Dev profile")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    with open(PLIST, "rb") as fh:
        data = plistlib.load(fh)

    settings = data.get("Window Settings") or {}
    default_name = data.get("Default Window Settings") or "Clear Dark"
    base = settings.get(default_name) or settings.get("Clear Dark") or next(iter(settings.values()))

    profile = deepcopy(base)
    profile["name"] = "Dev"
    profile["columnCount"] = 140
    profile["rowCount"] = 36
    profile["BackgroundBlur"] = 0.0
    profile["BackgroundBlurInactive"] = 0.0
    profile["FontAntialias"] = True
    profile["FontHeightSpacing"] = 1.05
    profile["FontWidthSpacing"] = 1.0
    profile["CursorBlink"] = False
    profile["ShowWindowSettingsNameInTitle"] = False
    profile["type"] = "Window Settings"
    profile["ProfileCurrentVersion"] = data.get(
        "ProfileCurrentVersion", profile.get("ProfileCurrentVersion", 2.09)
    )

    settings["Dev"] = profile
    data["Window Settings"] = settings
    data["Default Window Settings"] = "Dev"
    data["Startup Window Settings"] = "Dev"
    data["SecureKeyboardEntry"] = True

    if args.dry_run:
        print(json.dumps({
            "plist": PLIST,
            "default_profile": "Dev",
            "columns": profile["columnCount"],
            "rows": profile["rowCount"],
        }, ensure_ascii=False, indent=2))
        return 0

    backup = f"{PLIST}.backup-{time.strftime('%Y%m%d-%H%M%S')}"
    shutil.copy2(PLIST, backup)
    with open(PLIST, "wb") as fh:
        plistlib.dump(data, fh)
    print(json.dumps({"backup": backup, "profile": "Dev"}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
