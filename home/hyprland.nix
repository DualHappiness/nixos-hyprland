{ pkgs, ... }:
{
  programs.kitty.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      window.blur = true;
      font.normal.family = "Maple Mono NF";
      font.size = 12;
    };
  };

  programs.tofi.enable = true;
  home.file.".config/tofi/config".source = ./tofi.config;

  programs.waybar.enable = true;
  home.file.".config/waybar/config".source = ./waybar.config.json;
  home.file.".config/waybar/style.css".source = ./waybar.css;

  programs.rofi.enable = true;
  services.cliphist.enable = true;

  services.mako.enable = true;
  home.file.".config/mako/config".source = ./mako.config;

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };

  home.packages = with pkgs; [
    pulseaudio
    brightnessctl

    hyprls
    iwgtk
    blueberry
    grim
    slurp

    wl-clipboard
    # wl-clipboard-rs

    pyprland
    nautilus
  ];

  home.file.".config/hypr/pyprland.toml".source = ./pyprland.toml;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "papirus";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "mocha";
      };
    };
  };

  programs.hyprlock.enable = true;
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 150; # 2.5min.;
          on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }
        # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
        {
          timeout = 150; # 2.5min.
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight.
          on-resume = "brightnessctl -rd rgb:kbd_backlight"; # turn on keyboard backlight.
        }
        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }
        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };
}
