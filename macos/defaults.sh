#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

SCREENSHOT_DIR="${SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '+ '
    printf '%q ' "$@"
    printf '\n'
  else
    "$@"
  fi
}

echo "Configuring macOS defaults..."

run mkdir -p "$SCREENSHOT_DIR"

# Finder
run defaults write com.apple.finder AppleShowAllFiles -bool true
run defaults write NSGlobalDomain AppleShowAllExtensions -bool true
run defaults write com.apple.finder ShowPathbar -bool true
run defaults write com.apple.finder ShowStatusBar -bool true

# Dock
run defaults write com.apple.dock autohide -bool true
run defaults write com.apple.dock show-recents -bool false
run defaults write com.apple.dock autohide-delay -float 0
run defaults write com.apple.dock autohide-time-modifier -float 0.15

# Keyboard
run defaults write NSGlobalDomain KeyRepeat -int 1
run defaults write NSGlobalDomain InitialKeyRepeat -int 10
run defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Screenshots
run defaults write com.apple.screencapture location "$SCREENSHOT_DIR"
run defaults write com.apple.screencapture type -string png

# Trackpad
run defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
run defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
run defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
run defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# UI
run defaults write com.apple.controlcenter BatteryShowPercentage -bool true
run defaults write com.apple.menuextra.battery ShowPercent -string YES
run osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'

if [[ "$DRY_RUN" -eq 0 ]]; then
  for app in Finder Dock SystemUIServer; do
    killall "$app" >/dev/null 2>&1 || true
  done
fi

echo "Done. Screenshot folder: $SCREENSHOT_DIR"
