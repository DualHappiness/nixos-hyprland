{
  wayland.windowManager.hyprland.settings = {
    env = [
      "XCURSOR_SIZE,32"
      "XMODIFIERS, @im=fcitx5"
      # "GTK_IM_MODULE, wayland"
      # "QT_IM_MODULE, wayland"
      "SDL_IM_MODULE, fcitx5"
      "QT_QPA_PLATFORMTHEME, qt6ct"
    ];

    input = {
      kb_layout = "us";
      kb_variant = "";
      kb_model = "";
      follow_mouse = 1;
      follow_mouse_threshold = 100;

      touchpad = {
        natural_scroll = true;
      };

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      accel_profile = "flat";
    };
    general = {
      gaps_in = 4;
      gaps_out = 8;
      border_size = 4;
      allow_tearing = true;

      layout = "dwindle";
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
      workspace_swipe_distance = 200;
    };

    xwayland = {
      force_zero_scaling = true;
    };

    decoration = {
      rounding = 20;
      shadow = {
        enabled = true;
        range = 25;
      };
      blur = {
        enabled = true;
        size = 2;
        passes = 2;
        contrast = 1.2;
      };
    };

    dwindle = {
      pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true; # you probably want this
      split_width_multiplier = 1.4;
    };

    misc = {
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
      render_unfocused_fps = 60;
      disable_hyprland_logo = true;
    };
  };
}
