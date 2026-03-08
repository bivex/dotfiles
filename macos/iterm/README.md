## iTerm

Creates a `Dev` profile by cloning your current default profile and applying the dev-focused changes we chose:

- `Menlo 14`
- `scrollback = 50000`
- silent bell
- no flashing/visual bell
- no blinking cursor
- ligatures off

### Apply

```sh
python3 macos/iterm/apply_dev_profile.py
```

### Preview only

```sh
python3 macos/iterm/apply_dev_profile.py --dry-run
```
