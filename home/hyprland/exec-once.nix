{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
      "fcitx5"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "pypr --debug /tmp/pypr.log"
    ];
  };
}
