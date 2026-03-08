## Window management

Notes and configs related to macOS window managers and hotkey daemons.

### Included

- `yabairc` — real yabai configuration
- `skhdrc` — real skhd hotkey configuration
- `apply_configs.sh` — install configs into `~/.yabairc` / `~/.skhdrc` and (re)start services
- `capture_current_configs.sh` — sync current local configs back into dotfiles
- `check_configs.sh` — quick sanity checks for the versioned configs
- `doctor.sh` — diagnose yabai/skhd process state, Secure Input, and recent skhd errors
- `yabai-skhd.md` — summary of the current setup and hotkeys

The versioned `yabairc` also labels spaces `1..4` as `web`, `code`, `git`, and `chat` when those spaces exist.

### Apply

```sh
bash macos/window-management/apply_configs.sh
```

### Capture

```sh
bash macos/window-management/capture_current_configs.sh
```

### Diagnose

```sh
bash macos/window-management/doctor.sh
```
