#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$HOME/.yabairc" "$ROOT_DIR/yabairc"
cp "$HOME/.skhdrc" "$ROOT_DIR/skhdrc"
chmod +x "$ROOT_DIR/yabairc"
echo "Captured ~/.yabairc and ~/.skhdrc into $ROOT_DIR"
