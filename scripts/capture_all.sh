#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

python3 "$ROOT_DIR/zsh/capture_dev_layer.py"
python3 "$ROOT_DIR/macos/iterm/capture_current_profile.py"
python3 "$ROOT_DIR/macos/terminal/capture_current_profile.py"

echo "Captured zsh, iTerm, and Terminal.app settings into $ROOT_DIR"
