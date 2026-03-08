#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

bash "$ROOT_DIR/macos/defaults.sh"
python3 "$ROOT_DIR/macos/iterm/apply_dev_profile.py"
python3 "$ROOT_DIR/macos/terminal/apply_dev_profile.py"

echo "Applied macOS defaults, iTerm, and Terminal.app Dev presets from $ROOT_DIR"
