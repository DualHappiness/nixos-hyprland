{ pkgs, ... }:
{

  imports = [
    ./hyprland/hypridle.nix
    ./hyprland/hyprlock.nix
    ./hyprland/hyprpaper.nix
    ./hyprland/pyprland.nix

    ./hyprland/packages.nix

    ./hyprland/rofi.nix
    ./hyprland/mako.nix
    ./hyprland/waybar.nix
    ./hyprland/swayosd.nix

    ./hyprland/settings.nix
    ./hyprland/animations-end4.nix
    ./hyprland/binds.nix
    ./hyprland/rules.nix
    ./hyprland/workspace.nix
    ./hyprland/exec-once.nix
  ];
  programs.alacritty = {
    enable = true;
    settings = {
      window.blur = true;
      font.size = 12;
    };
  };

  services.hyprpolkitagent.enable = true;
  services.cliphist.enable = true;

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
    };
  };

  wayland.windowManager.hyprland.enable = true;
}
