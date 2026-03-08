 [![Tuned with ⚙️](https://a.b-b.top/badge.svg?repo=dotfiles&label=Tuned&background_color=009688&background_color2=26a69a&utm_source=github&utm_medium=readme&utm_campaign=badge)](https://a.b-b.top)

## Dotfiles

Personal development environment presets.

### Structure

- `git/` — reusable global git config layer
- `zsh/` — reusable interactive shell layer
- `macos/` — Terminal.app and iTerm presets
- `editors/` — editor-specific settings
- `formatters/` — formatter presets and notes
- `scripts/` — one-shot repo workflows

### Included

- `bootstrap.sh` — safe first-run bootstrap for zsh + macOS + terminal presets
- `git/gitconfig` — shared git defaults, aliases, pager, and behavior
- `git/gitconfig.local.example` — local-only git identity/signing template
- `git/gitignore_global` — global Git ignore for OS/editor junk
- `zsh/.zshrc.dev` — interactive dev shell layer without secrets
- `zsh/.zshrc.local.example` — machine-local shell overrides template
- `zsh/capture_dev_layer.py` — sync current local `~/.zshrc.dev` back into dotfiles
- `editors/cursor/settings.json` — Cursor settings
- `editors/vscode/settings.json` — VS Code-like settings
- `formatters/astyle/README.md` — AStyle presets for C# and C++
- `macos/defaults.sh` — Finder/Dock/keyboard/screenshot/trackpad/UI defaults
- `macos/power-user.sh` — extra opinionated macOS tweaks
- `macos/mission-control.sh` — Mission Control and hot corners preset
- `macos/iterm/apply_dev_profile.py` — creates/updates iTerm `Dev` profile
- `macos/iterm/capture_current_profile.py` — snapshot current iTerm profile into dotfiles
- `macos/terminal/apply_dev_profile.py` — creates/updates Terminal.app `Dev` profile
- `macos/terminal/capture_current_profile.py` — snapshot current Terminal.app profile into dotfiles
- `macos/window-management/yabai-skhd.md` — yabai/skhd notes
- `scripts/apply_all.sh` — apply both macOS terminal presets
- `scripts/capture_all.sh` — capture all supported dotfiles in one go
- `scripts/check_all.sh` — dry-run and smoke-check repo scripts
- `Makefile` — ergonomic entrypoint for apply/capture/check

### Quick start

```sh
make bootstrap
make apply
make power-user
make mission-control
make capture
make check
```

### Bootstrap a new machine

```sh
bash bootstrap.sh --dry-run
bash bootstrap.sh
```

Use `bash bootstrap.sh --with-homebrew` only when you have a `Brewfile` and want `brew bundle` to run.

`bootstrap.sh` also wires the versioned Git layer into `~/.gitconfig` and creates `~/.gitconfig.local` / `~/.gitignore_global` if they do not exist.

### Apply

1. `bash macos/defaults.sh`
2. `python3 macos/iterm/apply_dev_profile.py`
3. `python3 macos/terminal/apply_dev_profile.py`
4. Source `zsh/.zshrc.dev` from your local `~/.zshrc`

### Capture current local state back into the repo

```sh
bash scripts/capture_all.sh
```

### Verify repo scripts

```sh
bash scripts/check_all.sh
```

Each macOS script makes a timestamped backup of the original plist before changing it.

