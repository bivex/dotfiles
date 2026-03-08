## Terminal.app

Creates a `Dev` profile by cloning your current default profile and applying the dev-focused window tweaks we chose:

- `140x36`
- blur off
- antialias on
- line spacing `1.05`
- blinking cursor off
- secure keyboard entry on

### Apply

```sh
python3 macos/terminal/apply_dev_profile.py
```

### Preview only

```sh
python3 macos/terminal/apply_dev_profile.py --dry-run
```
