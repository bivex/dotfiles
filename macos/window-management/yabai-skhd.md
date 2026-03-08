## yabai + skhd

### Versioned `yabairc`

Layout and spacing:

- `layout bsp`
- `auto_balance on`
- `split_ratio 0.50`
- `window_placement second_child`
- padding/gaps: `8`

Mouse and focus:

- `focus_follows_mouse autoraise`
- `mouse_follows_focus off`
- `mouse_modifier alt`
- `mouse_action1 move`
- `mouse_action2 resize`
- `mouse_drop_action swap`

### Versioned `skhdrc`

- `alt + h/j/k/l` — focus west/south/north/east
- `alt + p` — focus recent window/space
- `shift + alt + h/j/k/l` — swap west/south/north/east
- `ctrl + shift + alt + h/j/k/l` — warp west/south/north/east
- `ctrl + alt + h/j/k/l` — resize window
- `alt + f` — toggle zoom fullscreen
- `shift + alt + f` — toggle parent zoom
- `alt + space` — toggle float
- `shift + alt + p` — toggle sticky/topmost
- `alt + 0` — rebalance space
- `ctrl + alt + 1..9` — focus space
- `ctrl + shift + alt + 1..9` — move window to space and follow it
- `ctrl + alt + n/b` — focus next/previous display
- `shift + alt + y` — restart yabai
- `ctrl + shift + alt + y` — restart skhd

### Summary

- `yabai`: BSP tiling, auto-balance enabled, gap/padding `8`
- `skhd`: navigation, warp/swap/resize, space/display moves, and service reload hotkeys
