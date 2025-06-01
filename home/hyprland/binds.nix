{ lib, ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      "$mainMod" = "SUPER";

      bind = [
        # shortcuts
        ",xf86audiomute, exec, pactl -- set-sink-mute @DEFAULT_SINK@ toggle"
        ",xf86audiolowervolume, exec, pactl -- set-sink-volume @DEFAULT_SINK@ -5%"
        ",xf86audioraisevolume, exec, pactl -- set-sink-volume @DEFAULT_SINK@ +5%"
        ",xf86audiomicmute, exec, pactl -- set-source-mute @DEFAULT_SOURCE@ toggle"
        ",xf86monbrightnessdown, exec, brightnessctl set 10%-"
        ",xf86monbrightnessup, exec, brightnessctl set 10%+"

        # Hyprland hotkeys
        "$mainMod, W, killactive"
        "$mainMod, grave, exec, uwsm app -- alacritty"
        "$mainMod SHIFT, M, exit"
        "$mainMod, E, exec, [float] nautilus --new-window"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, Y, togglesplit, # dwindle"
        "$mainMod, return, fullscreen"
        "$mainMod, F, togglefloating"
        "$mainMod, C, centerwindow"

        # launcher
        "$mainMod, space, exec, rofi -show drun"

        # Hyprland reload exec-once services
        "$mainMod CTRL ALT, R, exec, killall waybar; waybar"
        "$mainMod CTRL ALT, R, exec, killall fcitx5; fcitx5"

        # clipboard
        "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        # Screenshot
        ''$mainMod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy''
        ''$mainMod SHIFT, W, exec, grim -g \"$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | wl-copy''
        ",print , exec, grim - | wl-copy"

        "$mainMod SHIFT CTRL, L, exec, loginctl lock-session"

        "$mainMod, slash, exec, list-keybinds"
        "$mainMod SHIFT, escape, exec, wlogout"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        # pyprland
        "$mainMod, Q, exec, pypr toggle term"
        "$mainMod SHIFT, Z, exec, pypr zoom ++0.5"
        "$mainMod, Z, exec, pypr zoom"

        # Switch workspaces with mainMod + [1-5]
        "$mainMod, 1, workspace,  1"
        "$mainMod, 2, workspace,  2"
        "$mainMod, 3, workspace,  3"
        "$mainMod, 4, workspace,  4"
        "$mainMod, 5, workspace,  5"
        "$mainMod, 6, workspace,  6"
        "$mainMod, 7, workspace,  7"
        "$mainMod, 8, workspace,  8"
        "$mainMod, 9, workspace,  9"
        "$mainMod, 0, workspace,  10"
        "$mainMod, X, togglespecialworkspace"
        "$mainMod, TAB, workspace, e+1"
        "$mainMod SHIFT, TAB, workspace, e-1"

        # Move active window to a workspace with mainMod + SHIFT + [1-5]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod SHIFT, X, movetoworkspace, special"

        "$mainMod SHIFT, left, movecurrentworkspacetomonitor, l"
        "$mainMod SHIFT, right, movecurrentworkspacetomonitor, r"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
    extraConfig = lib.mkAfter ''
      # Resize
      bind = $mainMod, R, submap, resize
      submap = resize
      binde =, right, resizeactive, 10 0
      binde =, left, resizeactive, -10 0
      binde =, up, resizeactive, 0 -10
      binde =, down, resizeactive, 0 10
      binde =, l, resizeactive, 10 0
      binde =, h, resizeactive, -10 0
      binde =, k, resizeactive, 0 -10
      binde =, j, resizeactive, 0 10
      bind = , C, centerwindow, 
      bind =, escape, submap, reset
      bind = $mainMod, R, submap, reset
      submap = reset

      # Move
      bind = $mainMod, M, submap, move
      submap = move
      binde =, right, moveactive, 30 0
      binde =, left, moveactive, -30 0
      binde =, up, moveactive, 0 -30
      binde =, down, moveactive, 0 30
      binde =, l, moveactive, 30 0
      binde =, h, moveactive, -30 0
      binde =, k, moveactive, 0 -30
      binde =, j, moveactive, 0 30
      bind =, escape, submap, reset
      bind = $mainMod, M, submap, reset
      submap = reset
    '';
  };
}
