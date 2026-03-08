## macOS presets

This directory stores reproducible terminal presets and macOS system defaults.

### Included

- `defaults.sh` — Finder, Dock, keyboard, screenshot, trackpad, and UI defaults
- `iterm/` — iTerm Dev profile apply/capture scripts
- `terminal/` — Terminal.app Dev profile apply/capture scripts
- `window-management/` — yabai and skhd notes

Use the root `Makefile` or `scripts/*.sh` wrappers to apply or capture both at once.

### Apply system defaults only

```sh
bash macos/defaults.sh
```

