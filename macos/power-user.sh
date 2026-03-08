#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

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

echo "Configuring macOS power-user layer..."

# Finder
run defaults write com.apple.finder _FXSortFoldersFirst -bool true
run defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
run defaults write com.apple.finder FXDefaultSearchScope -string SCcf
run defaults write com.apple.finder NewWindowTarget -string PfHm
run defaults write com.apple.finder NewWindowTargetPath -string "$HOME_URL"
run defaults write com.apple.finder QLEnableTextSelection -bool true

# Dock
run defaults write com.apple.dock minimize-to-application -bool true
run defaults write com.apple.dock mineffect -string scale
run defaults write com.apple.dock launchanim -bool false
run defaults write com.apple.dock mru-spaces -bool false

# Keyboard / text input
run defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
run defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
run defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
run defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
run defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
run defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Screenshots / UI
run defaults write com.apple.screencapture disable-shadow -bool true
run defaults write NSGlobalDomain AppleShowScrollBars -string Always
run defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
run defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
run defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
run defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

if [[ "$DRY_RUN" -eq 0 ]]; then
  for app in Finder Dock SystemUIServer; do
    killall "$app" >/dev/null 2>&1 || true
  done
fi

echo "Done with macOS power-user layer."
