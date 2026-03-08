#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

bash "$ROOT_DIR/macos/defaults.sh" --dry-run
bash "$ROOT_DIR/macos/power-user.sh" --dry-run
bash "$ROOT_DIR/macos/mission-control.sh" --dry-run
bash "$ROOT_DIR/macos/window-management/check_configs.sh"
python3 "$ROOT_DIR/macos/iterm/apply_dev_profile.py" --dry-run
python3 "$ROOT_DIR/macos/terminal/apply_dev_profile.py" --dry-run

TMP_GIT_HOME="$(mktemp -d)"
cp "$ROOT_DIR/git/gitignore_global" "$TMP_GIT_HOME/.gitignore_global"
cp "$ROOT_DIR/git/gitconfig.local.example" "$TMP_GIT_HOME/.gitconfig.local"
cat > "$TMP_GIT_HOME/.gitconfig" <<EOF
[include]
	path = $ROOT_DIR/git/gitconfig
[include]
	path = ~/.gitconfig.local
EOF
HOME="$TMP_GIT_HOME" git config --global --includes alias.st >/dev/null
HOME="$TMP_GIT_HOME" git config --global --includes core.excludesfile >/dev/null

TMP_ZDOTDIR="$(mktemp -d)"
trap 'rm -rf "$TMP_ZDOTDIR" "$TMP_GIT_HOME"' EXIT

ZDOTDIR="$TMP_ZDOTDIR" zsh -i -c "source \"$ROOT_DIR/zsh/.zshrc.dev\"; alias gs; whence -w mkcd; whence -w ff; echo OK"

echo "Dry-run checks passed for dotfiles in $ROOT_DIR"
