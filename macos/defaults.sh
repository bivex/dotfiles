#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

SCREENSHOT_DIR="${SCREENSHOT_DIR:-$HOME/Pictures/Screenshots}"
HOME_URL="file://${HOME}/"

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
run defaults write com.apple.finder _FXSortFoldersFirst -bool true
run defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
run defaults write com.apple.finder FXDefaultSearchScope -string SCcf
run defaults write com.apple.finder NewWindowTarget -string PfHm
run defaults write com.apple.finder NewWindowTargetPath -string "$HOME_URL"
run defaults write com.apple.finder QLEnableTextSelection -bool true

# Dock
run defaults write com.apple.dock autohide -bool true
run defaults write com.apple.dock show-recents -bool false
run defaults write com.apple.dock autohide-delay -float 0
run defaults write com.apple.dock autohide-time-modifier -float 0.15
run defaults write com.apple.dock minimize-to-application -bool true
run defaults write com.apple.dock mineffect -string scale
run defaults write com.apple.dock launchanim -bool false
run defaults write com.apple.dock mru-spaces -bool false

# Keyboard
run defaults write NSGlobalDomain KeyRepeat -int 1
run defaults write NSGlobalDomain InitialKeyRepeat -int 10
run defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
run defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
run defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
run defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
run defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
run defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
run defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Screenshots
run defaults write com.apple.screencapture location "$SCREENSHOT_DIR"
run defaults write com.apple.screencapture type -string png
run defaults write com.apple.screencapture disable-shadow -bool true

# Trackpad
run defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
run defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
run defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
run defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# UI
run defaults write com.apple.controlcenter BatteryShowPercentage -bool true
run defaults write com.apple.menuextra.battery ShowPercent -string YES
run defaults write NSGlobalDomain AppleShowScrollBars -string Always
run defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
run defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
run defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
run defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
run osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'

if [[ "$DRY_RUN" -eq 0 ]]; then
  for app in Finder Dock SystemUIServer; do
    killall "$app" >/dev/null 2>&1 || true
  done
fi

echo "Done. Screenshot folder: $SCREENSHOT_DIR"
