{ lib, pkgs, ... }:
{
  programs.kitty.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      window.blur = true;
      font.size = 12;
    };
  };

  # TODO: use rofi instead
  programs.tofi.enable = true;
  # home.file.".config/tofi/config".source = ./tofi.config;
  programs.rofi.enable = true;

  services.cliphist.enable = true;
  services.mako = {
    enable = true;
    settings = {
      sort = "-time";
      layer = "overlay";
      width = 450;
      height = 150;
      border-size = 1;
      border-radius = 12;
      icons = 1;
      max-icon-size = 64;
      default-timeout = 5000;
      ignore-timeout = 0;
      margin = 12;
      padding = "12,20";

      # NOTE: stylix work wrong with font size
      # font = lib.mkForce "Sarasa Term SC 16";

      "urgency=critical" = {
        default-timeout = 0;
      };

    };
  };

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

  programs.hyprlock.enable = true;
  services.hyprpolkitagent.enable = true;

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/backgrounds/current.jpg" ];
      wallpaper = [ ",~/backgrounds/current.jpg" ];
    };
  };
}
