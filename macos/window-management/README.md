## Window management

Notes and configs related to macOS window managers and hotkey daemons.

### Included

- `yabairc` — real yabai configuration
- `skhdrc` — real skhd hotkey configuration
- `apply_configs.sh` — install configs into `~/.yabairc` / `~/.skhdrc` and (re)start services
- `capture_current_configs.sh` — sync current local configs back into dotfiles
- `check_configs.sh` — quick sanity checks for the versioned configs
- `yabai-skhd.md` — summary of the current setup and hotkeys

### Apply

```sh
bash macos/window-management/apply_configs.sh
```

### Capture

```sh
bash macos/window-management/capture_current_configs.sh
```
