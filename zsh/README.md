## zsh

This repository stores only the reusable interactive dev layer.

### Add it to your local `~/.zshrc`

```sh
[ -f "/Volumes/External/Code/dotfiles/zsh/.zshrc.dev" ] && source "/Volumes/External/Code/dotfiles/zsh/.zshrc.dev"
```

Keep machine-specific PATH exports, tokens, and local integrations in your real `~/.zshrc` or `~/.zprofile`.

### Capture current local dev layer back into dotfiles

```sh
python3 zsh/capture_dev_layer.py
```

