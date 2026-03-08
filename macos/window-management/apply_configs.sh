#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '+ '
    printf '%q ' "$@"
    printf '\n'
  else
    "$@"
  fi
}

sync_file() {
  local src="$1" dst="$2"
  if [[ -f "$dst" ]] && cmp -s "$src" "$dst"; then
    return 0
  fi
  if [[ -f "$dst" ]]; then
    local backup="${dst}.backup-$(date +%Y%m%d-%H%M%S)"
    [[ "$DRY_RUN" -eq 1 ]] && echo "+ backup $dst -> $backup" || cp "$dst" "$backup"
  fi
  run cp "$src" "$dst"
}

service_action() {
  local bin="$1"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "+ $bin --restart-service || ($bin --install-service; $bin --start-service)"
    return 0
  fi
  "$bin" --restart-service >/dev/null 2>&1 || {
    "$bin" --install-service >/dev/null 2>&1 || true
    "$bin" --start-service >/dev/null 2>&1 || true
  }
}

warn_if_skhd_blocked() {
  local log="/tmp/skhd_${USER}.err.log"
  [[ -f "$log" ]] || return 0
  if rg -q 'must be run with accessibility access' "$log"; then
    echo "WARNING: skhd still needs Accessibility access in System Settings > Privacy & Security > Accessibility."
  fi
  if rg -q 'secure keyboard entry is enabled' "$log"; then
    echo "WARNING: skhd is blocked by Secure Keyboard Entry from another app. Close or reconfigure that app, then rerun this script."
  fi
}

echo "Applying yabai/skhd configs from $ROOT_DIR"
sync_file "$ROOT_DIR/yabairc" "$HOME/.yabairc"
sync_file "$ROOT_DIR/skhdrc" "$HOME/.skhdrc"
run chmod +x "$HOME/.yabairc"

# skhd does not work reliably while Secure Keyboard Entry is enabled in Terminal.app.
run defaults write com.apple.Terminal SecureKeyboardEntry -bool false

if command -v yabai >/dev/null 2>&1; then
  service_action yabai
fi
if command -v skhd >/dev/null 2>&1; then
  service_action skhd
  warn_if_skhd_blocked
fi

echo "Applied yabai/skhd config. If hotkeys still do not react, close Terminal windows using Secure Keyboard Entry and reopen them."
