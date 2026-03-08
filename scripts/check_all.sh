#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

bash "$ROOT_DIR/macos/defaults.sh" --dry-run
python3 "$ROOT_DIR/macos/iterm/apply_dev_profile.py" --dry-run
python3 "$ROOT_DIR/macos/terminal/apply_dev_profile.py" --dry-run

TMP_ZDOTDIR="$(mktemp -d)"
trap 'rm -rf "$TMP_ZDOTDIR"' EXIT

ZDOTDIR="$TMP_ZDOTDIR" zsh -i -c "source \"$ROOT_DIR/zsh/.zshrc.dev\"; alias gs; whence -w mkcd; whence -w ff; echo OK"

echo "Dry-run checks passed for dotfiles in $ROOT_DIR"
