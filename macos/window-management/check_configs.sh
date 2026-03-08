#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sh -n "$ROOT_DIR/yabairc"
grep -q 'label_space 1 web' "$ROOT_DIR/yabairc"
grep -q 'label_space 4 chat' "$ROOT_DIR/yabairc"
grep -q 'space=1' "$ROOT_DIR/yabairc"
grep -q 'GitKraken' "$ROOT_DIR/yabairc"
grep -q 'alt - h' "$ROOT_DIR/skhdrc"
grep -q 'ctrl + alt - 1' "$ROOT_DIR/skhdrc"
grep -q 'shift + alt - y' "$ROOT_DIR/skhdrc"

echo "yabai/skhd config sanity checks passed for $ROOT_DIR"
