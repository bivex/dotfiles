 [![Tuned with ⚙️](https://a.b-b.top/badge.svg?repo=dotfiles&label=Tuned&background_color=009688&background_color2=26a69a&utm_source=github&utm_medium=readme&utm_campaign=badge)](https://a.b-b.top)

## Dotfiles

Personal development environment presets.

### Included

- `zsh/.zshrc.dev` — interactive dev shell layer without secrets
- `zsh/capture_dev_layer.py` — sync current local `~/.zshrc.dev` back into dotfiles
- `macos/iterm/apply_dev_profile.py` — creates/updates iTerm `Dev` profile
- `macos/iterm/capture_current_profile.py` — snapshot current iTerm profile into dotfiles
- `macos/terminal/apply_dev_profile.py` — creates/updates Terminal.app `Dev` profile
- `macos/terminal/capture_current_profile.py` — snapshot current Terminal.app profile into dotfiles
- `scripts/capture_all.sh` — capture all supported dotfiles in one go

### Apply

1. `python3 macos/iterm/apply_dev_profile.py`
2. `python3 macos/terminal/apply_dev_profile.py`
3. Source `zsh/.zshrc.dev` from your local `~/.zshrc`

### Capture current local state back into the repo

```sh
bash scripts/capture_all.sh
```

Each macOS script makes a timestamped backup of the original plist before changing it.

