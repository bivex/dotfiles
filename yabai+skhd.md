● Текущий ~/.yabairc

  .yabairc (EXCERPT)
  #!/usr/bin/env sh
  # Layout
  yabai -m config layout bsp
  yabai -m config auto_balance on
  yabai -m config split_ratio 0.50
  yabai -m config window_placement second_child
  yabai -m config window_zoom_persist on
  # Spacing
  yabai -m config top_padding 8
  yabai -m config bottom_padding 8
  yabai -m config left_padding 8
  yabai -m config right_padding 8
  yabai -m config window_gap 8
  # Mouse / focus
  yabai -m config focus_follows_mouse autoraise
  yabai -m config mouse_follows_focus off
  yabai -m config mouse_modifier alt
  yabai -m config mouse_action1 move
  yabai -m config mouse_action2 resize
  yabai -m config mouse_drop_action swap

  Текущий ~/.skhdrc

  .skhdrc (EXCERPT)
  # Focus windows
  alt - h : yabai -m window --focus west
  alt - j : yabai -m window --focus south
  alt - k : yabai -m window --focus north
  alt - l : yabai -m window --focus east

  # Swap windows
  shift + alt - h : yabai -m window --swap west
  shift + alt - j : yabai -m window --swap south
  shift + alt - k : yabai -m window --swap north
  shift + alt - l : yabai -m window --swap east
  # Resize windows
  ctrl + alt - h : yabai -m window --resize left:-40:0
  ctrl + alt - j : yabai -m window --resize bottom:0:40
  ctrl + alt - k : yabai -m window --resize top:0:-40
  ctrl + alt - l : yabai -m window --resize right:40:0

  # Layout helpers
  alt - f : yabai -m window --toggle zoom-fullscreen
  shift + alt - space : yabai -m window --toggle float
  alt - 0 : yabai -m space --balance

  Коротко что это значит

    • yabai:
       • тайлинг bsp
       • авто-баланс размеров включён
       • gap/отступы по 8
       • Alt + ЛКМ — move
       • Alt + ПКМ — resize

    • skhd:
       • Alt + h/j/k/l — переход между окнами
       • Shift + Alt + h/j/k/l — swap окон
       • Ctrl + Alt + h/j/k/l — resize
       • Alt + f — zoom-fullscreen
       • Shift + Alt + Space — float
       • Alt + 0 — rebalance
