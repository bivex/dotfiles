#!/usr/bin/env bash
set -euo pipefail

section() {
  printf '\n## %s\n' "$1"
}

show_process() {
  local name="$1"
  if pgrep -af "(^|/)${name}( |$)" >/dev/null 2>&1; then
    echo "$name: running"
    pgrep -af "(^|/)${name}( |$)"
  else
    echo "$name: not running"
  fi
}

show_launch_agent() {
  local label
  for label in com.asmvik.yabai com.koekeishiya.yabai com.koekeishiya.skhd homebrew.mxcl.yabai homebrew.mxcl.skhd; do
    if launchctl print "gui/$(id -u)/$label" >/dev/null 2>&1; then
      echo "$label: loaded"
    fi
  done
}

section "Processes"
show_process yabai
show_process skhd

section "Launch agents"
show_launch_agent || true

section "Accessibility"
if osascript -e 'tell application "System Events" to get UI elements enabled' >/tmp/window-mgmt-ui.out 2>/dev/null; then
  printf 'UI scripting enabled: %s\n' "$(cat /tmp/window-mgmt-ui.out)"
else
  echo "UI scripting enabled: unknown"
fi
rm -f /tmp/window-mgmt-ui.out

section "Secure Input"
SECURE_INPUT_PID="$(ioreg -l -w 0 2>/dev/null | awk '/kCGSSessionSecureInputPID/ {gsub(/[^0-9]/, "", $0); if ($0 != "") {print $0; exit}}')"
if [[ -n "${SECURE_INPUT_PID:-}" ]]; then
  echo "Secure Input: ACTIVE"
  echo "PID: $SECURE_INPUT_PID"
  ps -p "$SECURE_INPUT_PID" -o pid=,comm=,args= 2>/dev/null || true
else
  echo "Secure Input: inactive"
fi

section "Terminal Secure Keyboard Entry"
defaults read com.apple.Terminal SecureKeyboardEntry 2>/dev/null || echo "__MISSING__"

section "yabai reachability"
if yabai -m query --spaces >/tmp/window-mgmt-yabai.json 2>/dev/null; then
  python3 - <<'PY' /tmp/window-mgmt-yabai.json
import json, sys
with open(sys.argv[1]) as f:
    data = json.load(f)
print(f"spaces={len(data)}")
for s in data:
    print(f"space={s.get('index')} label={s.get('label','')} display={s.get('display')} visible={s.get('is-visible')}")
PY
else
  echo "yabai query failed"
fi
rm -f /tmp/window-mgmt-yabai.json

section "Recent skhd errors"
if [[ -f "/tmp/skhd_${USER}.err.log" ]]; then
  tail -n 20 "/tmp/skhd_${USER}.err.log"
else
  echo "No skhd error log found"
fi
