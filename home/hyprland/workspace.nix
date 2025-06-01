{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, highres, auto, 1.6"
      "HDMI-A-1, highres, auto-right, 1"
      ", highres, auto-right, 1, transform, 3"
    ];
    # Bind workspace
    workspace = [
      "r[1-3], monitor:0"
      "r[4-7], monitor:1"
      "r[8], monitor:2"
    ];
  };
}
