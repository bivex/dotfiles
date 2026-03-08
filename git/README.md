## Git

Reusable global Git defaults live here.

### Included

- `gitconfig` — shared behavior, aliases, pager, rerere, prune, rebase defaults
- `gitignore_global` — safe OS/editor junk ignore list
- `gitconfig.local.example` — local-only identity/signing template

Edit `~/.gitconfig.local` yourself after bootstrap to set your real `user.name` / `user.email` and optional signing preferences.

### Apply

Preferred:

```sh
bash bootstrap.sh
```

Manual include example:

```sh
[include]
	path = /Volumes/External/Code/dotfiles/git/gitconfig
[include]
	path = ~/.gitconfig.local
```
