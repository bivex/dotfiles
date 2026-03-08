 [![Tuned with ⚙️](https://a.b-b.top/badge.svg?repo=dotfiles&label=Tuned&background_color=009688&background_color2=26a69a&utm_source=github&utm_medium=readme&utm_campaign=badge)](https://a.b-b.top)

## Dotfiles

Personal development environment presets.

### Included

- `zsh/.zshrc.dev` — interactive dev shell layer without secrets
- `macos/iterm/apply_dev_profile.py` — creates/updates iTerm `Dev` profile
- `macos/terminal/apply_dev_profile.py` — creates/updates Terminal.app `Dev` profile

### Apply

1. `python3 macos/iterm/apply_dev_profile.py`
2. `python3 macos/terminal/apply_dev_profile.py`
3. Source `zsh/.zshrc.dev` from your local `~/.zshrc`

Each macOS script makes a timestamped backup of the original plist before changing it.

