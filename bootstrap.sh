#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0
WITH_HOMEBREW=0
SKIP_GIT=0
SKIP_ZSH=0
SKIP_MACOS=0
SKIP_POWER_USER=0
SKIP_MISSION_CONTROL=0
SKIP_WINDOW_MANAGEMENT=0
SKIP_TERMINALS=0
SKIP_CHECK=0

usage() {
  cat <<EOF
Usage: bash bootstrap.sh [options]

Options:
  --dry-run              Print what would happen without changing anything
  --with-homebrew        Run brew bundle if a Brewfile exists
  --skip-git             Do not wire ~/.gitconfig and ~/.gitconfig.local
  --skip-zsh             Do not wire ~/.zshrc and ~/.zshrc.local
  --skip-macos           Skip macos/defaults.sh
  --skip-power-user      Skip macos/power-user.sh
  --skip-mission-control Skip macos/mission-control.sh
  --skip-window-management Skip macos/window-management/apply_configs.sh
  --skip-terminals       Skip iTerm and Terminal.app profile setup
  --skip-check           Skip scripts/check_all.sh at the end
  -h, --help             Show this help
EOF
}

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '+ '
    printf '%q ' "$@"
    printf '\n'
  else
    "$@"
  fi
}

find_brewfile() {
  for path in "$ROOT_DIR/homebrew/Brewfile" "$ROOT_DIR/Brewfile"; do
    [[ -f "$path" ]] && { echo "$path"; return 0; }
  done
  return 1
}

wire_zsh() {
  local zshrc="$HOME/.zshrc"
  local example="$ROOT_DIR/zsh/.zshrc.local.example"
  local local_rc="$HOME/.zshrc.local"
  local backup="${zshrc}.backup-$(date +%Y%m%d-%H%M%S)"
  local block_start="# >>> dotfiles bootstrap >>>"
  local block_end="# <<< dotfiles bootstrap <<<"

  if [[ ! -f "$zshrc" ]]; then
    [[ "$DRY_RUN" -eq 1 ]] && echo "+ create $zshrc" || : > "$zshrc"
  else
    [[ "$DRY_RUN" -eq 1 ]] && echo "+ backup $zshrc -> $backup" || cp "$zshrc" "$backup"
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "+ ensure managed zsh bootstrap block in $zshrc"
  else
    python3 - "$zshrc" "$ROOT_DIR" "$block_start" "$block_end" <<'PY'
from pathlib import Path
import sys
path = Path(sys.argv[1])
root = sys.argv[2]
start = sys.argv[3]
end = sys.argv[4]
block = f'''{start}\n[ -f "{root}/zsh/.zshrc.dev" ] && source "{root}/zsh/.zshrc.dev"\n[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"\n{end}\n'''
text = path.read_text(encoding='utf-8') if path.exists() else ''
if start in text and end in text:
    before, rest = text.split(start, 1)
    _, after = rest.split(end, 1)
    text = before.rstrip() + '\n\n' + block + after.lstrip('\n')
else:
    text = text.rstrip() + ('\n\n' if text.strip() else '') + block
path.write_text(text if text.endswith('\n') else text + '\n', encoding='utf-8')
PY
  fi

  if [[ ! -f "$local_rc" && -f "$example" ]]; then
    [[ "$DRY_RUN" -eq 1 ]] && echo "+ copy $example -> $local_rc" || cp "$example" "$local_rc"
  fi
}

wire_git() {
  local gitconfig="$HOME/.gitconfig"
  local example="$ROOT_DIR/git/gitconfig.local.example"
  local local_gitconfig="$HOME/.gitconfig.local"
  local ignore_src="$ROOT_DIR/git/gitignore_global"
  local ignore_dst="$HOME/.gitignore_global"
  local backup="${gitconfig}.backup-$(date +%Y%m%d-%H%M%S)"
  local block_start="# >>> dotfiles bootstrap >>>"
  local block_end="# <<< dotfiles bootstrap <<<"

  if [[ ! -f "$gitconfig" ]]; then
    [[ "$DRY_RUN" -eq 1 ]] && echo "+ create $gitconfig" || : > "$gitconfig"
  else
    [[ "$DRY_RUN" -eq 1 ]] && echo "+ backup $gitconfig -> $backup" || cp "$gitconfig" "$backup"
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "+ ensure managed git bootstrap block in $gitconfig"
  else
    python3 - "$gitconfig" "$ROOT_DIR" "$block_start" "$block_end" <<'PY'
from pathlib import Path
import sys
path = Path(sys.argv[1])
root = sys.argv[2]
start = sys.argv[3]
end = sys.argv[4]
block = f'''{start}\n[include]\n\tpath = {root}/git/gitconfig\n[include]\n\tpath = ~/.gitconfig.local\n{end}\n'''
text = path.read_text(encoding='utf-8') if path.exists() else ''
if start in text and end in text:
    before, rest = text.split(start, 1)
    _, after = rest.split(end, 1)
    text = before.rstrip() + '\n\n' + block + after.lstrip('\n')
else:
    text = text.rstrip() + ('\n\n' if text.strip() else '') + block
path.write_text(text if text.endswith('\n') else text + '\n', encoding='utf-8')
PY
  fi

  if [[ ! -f "$local_gitconfig" && -f "$example" ]]; then
    [[ "$DRY_RUN" -eq 1 ]] && echo "+ copy $example -> $local_gitconfig" || cp "$example" "$local_gitconfig"
  fi
  if [[ ! -f "$ignore_dst" && -f "$ignore_src" ]]; then
    [[ "$DRY_RUN" -eq 1 ]] && echo "+ copy $ignore_src -> $ignore_dst" || cp "$ignore_src" "$ignore_dst"
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    --with-homebrew) WITH_HOMEBREW=1 ;;
    --skip-git) SKIP_GIT=1 ;;
    --skip-zsh) SKIP_ZSH=1 ;;
    --skip-macos) SKIP_MACOS=1 ;;
    --skip-power-user) SKIP_POWER_USER=1 ;;
    --skip-mission-control) SKIP_MISSION_CONTROL=1 ;;
    --skip-window-management) SKIP_WINDOW_MANAGEMENT=1 ;;
    --skip-terminals) SKIP_TERMINALS=1 ;;
    --skip-check) SKIP_CHECK=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
  shift
done

echo "Bootstrapping dotfiles from $ROOT_DIR"

[[ "$SKIP_GIT" -eq 1 ]] || wire_git
[[ "$SKIP_ZSH" -eq 1 ]] || wire_zsh

if [[ "$WITH_HOMEBREW" -eq 1 ]]; then
  if command -v brew >/dev/null 2>&1; then
    if BREWFILE="$(find_brewfile)"; then
      run brew bundle --file="$BREWFILE"
    else
      echo "No Brewfile found under $ROOT_DIR; skipping Homebrew bundle."
    fi
  else
    echo "Homebrew is not installed; skipping brew bundle."
  fi
fi

if [[ "$SKIP_MACOS" -eq 0 ]]; then
  if [[ "$DRY_RUN" -eq 1 ]]; then
    run bash "$ROOT_DIR/macos/defaults.sh" --dry-run
  else
    run bash "$ROOT_DIR/macos/defaults.sh"
  fi
fi
if [[ "$SKIP_POWER_USER" -eq 0 ]]; then
  if [[ "$DRY_RUN" -eq 1 ]]; then
    run bash "$ROOT_DIR/macos/power-user.sh" --dry-run
  else
    run bash "$ROOT_DIR/macos/power-user.sh"
  fi
fi
if [[ "$SKIP_MISSION_CONTROL" -eq 0 ]]; then
  if [[ "$DRY_RUN" -eq 1 ]]; then
    run bash "$ROOT_DIR/macos/mission-control.sh" --dry-run
  else
    run bash "$ROOT_DIR/macos/mission-control.sh"
  fi
fi
if [[ "$SKIP_WINDOW_MANAGEMENT" -eq 0 ]]; then
  if [[ "$DRY_RUN" -eq 1 ]]; then
    run bash "$ROOT_DIR/macos/window-management/apply_configs.sh" --dry-run
  else
    run bash "$ROOT_DIR/macos/window-management/apply_configs.sh"
  fi
fi
if [[ "$SKIP_TERMINALS" -eq 0 ]]; then
  if [[ "$DRY_RUN" -eq 1 ]]; then
    run python3 "$ROOT_DIR/macos/iterm/apply_dev_profile.py" --dry-run
    run python3 "$ROOT_DIR/macos/terminal/apply_dev_profile.py" --dry-run
  else
    run python3 "$ROOT_DIR/macos/iterm/apply_dev_profile.py"
    run python3 "$ROOT_DIR/macos/terminal/apply_dev_profile.py"
  fi
fi
if [[ "$SKIP_CHECK" -eq 0 ]]; then
  run bash "$ROOT_DIR/scripts/check_all.sh"
fi

echo "Bootstrap complete."
