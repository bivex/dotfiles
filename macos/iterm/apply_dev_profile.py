#!/usr/bin/env python3
import argparse
import json
import os
import plistlib
import shutil
import time
import uuid
from copy import deepcopy

PLIST = os.path.expanduser("~/Library/Preferences/com.googlecode.iterm2.plist")


def main() -> int:
    parser = argparse.ArgumentParser(description="Create/update iTerm Dev profile")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    with open(PLIST, "rb") as fh:
        data = plistlib.load(fh)

    bookmarks = data.get("New Bookmarks", [])
    default_guid = data.get("Default Bookmark Guid")
    base = next((p for p in bookmarks if p.get("Guid") == default_guid), None)
    if base is None and bookmarks:
        base = bookmarks[0]
    if base is None:
        raise SystemExit("No iTerm profiles found")

    bookmarks = [
        p for p in bookmarks
        if not (p.get("Name") == "Dev" and p.get("Tags") == ["dotfiles-managed"])
    ]

    profile = deepcopy(base)
    profile["Name"] = "Dev"
    profile["Guid"] = str(uuid.uuid4()).upper()
    profile["Tags"] = ["dotfiles-managed"]
    profile["Normal Font"] = "Menlo-Regular 14"
    profile["Non Ascii Font"] = "Menlo-Regular 14"
    profile["Use Non-ASCII Font"] = True
    profile["Horizontal Spacing"] = 1.0
    profile["Vertical Spacing"] = 1.1
    profile["Unlimited Scrollback"] = False
    profile["Scrollback Lines"] = 50000
    profile["Silence Bell"] = True
    profile["Visual Bell"] = False
    profile["Flashing Bell"] = False
    profile["Blinking Cursor"] = False
    profile["Use Bold Font"] = True
    profile["Use Bright Bold"] = True
    profile["ASCII Ligatures"] = False
    profile["Close Sessions On End"] = True
    profile["Working Directory"] = os.path.expanduser("~")

    data["New Bookmarks"] = [*bookmarks, profile]
    data["Default Bookmark Guid"] = profile["Guid"]

    if args.dry_run:
        print(json.dumps({
            "plist": PLIST,
            "default_profile": profile["Name"],
            "font": profile["Normal Font"],
            "scrollback": profile["Scrollback Lines"],
        }, ensure_ascii=False, indent=2))
        return 0

    backup = f"{PLIST}.backup-{time.strftime('%Y%m%d-%H%M%S')}"
    shutil.copy2(PLIST, backup)
    with open(PLIST, "wb") as fh:
        plistlib.dump(data, fh)
    print(json.dumps({"backup": backup, "profile": profile["Name"]}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
