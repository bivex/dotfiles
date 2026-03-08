## macOS presets

This directory stores reproducible terminal presets and macOS system defaults.

### Included

- `defaults.sh` — Finder, Dock, keyboard, screenshot, trackpad, and UI defaults
- `power-user.sh` — extra opinionated Finder/Dock/keyboard/UI tweaks
- `mission-control.sh` — Mission Control and hot corners preset
- `iterm/` — iTerm Dev profile apply/capture scripts
- `terminal/` — Terminal.app Dev profile apply/capture scripts
- `window-management/` — real yabai/skhd configs plus apply/capture/check scripts

Use the root `Makefile` or `scripts/*.sh` wrappers to apply or capture both at once.

### Apply system defaults only

```sh
bash macos/defaults.sh
```

### Apply the power-user layer

```sh
bash macos/power-user.sh
```

### Apply Mission Control + hot corners

```sh
bash macos/mission-control.sh
```


