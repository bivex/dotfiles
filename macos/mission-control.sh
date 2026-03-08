#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '+ '
    printf '%q ' "$@"
    printf '\n'
  else
    "$@"
  fi
}

echo "Configuring Mission Control and hot corners..."

# Mission Control
run defaults write com.apple.dock expose-group-apps -bool false

# Hot corners
# 2 = Mission Control, 3 = Application Windows, 4 = Desktop, 14 = Quick Note
run defaults write com.apple.dock wvous-tl-corner -int 2
run defaults write com.apple.dock wvous-tl-modifier -int 0
run defaults write com.apple.dock wvous-tr-corner -int 3
run defaults write com.apple.dock wvous-tr-modifier -int 0
run defaults write com.apple.dock wvous-bl-corner -int 4
run defaults write com.apple.dock wvous-bl-modifier -int 0
run defaults write com.apple.dock wvous-br-corner -int 14
run defaults write com.apple.dock wvous-br-modifier -int 0

if [[ "$DRY_RUN" -eq 0 ]]; then
  killall Dock >/dev/null 2>&1 || true
fi

echo "Done with Mission Control and hot corners."
