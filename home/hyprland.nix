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

  home.packages = with pkgs; [
    pulseaudio
    brightnessctl
    
    hyprls
    iwgtk
    blueberry
    grim
    slurp

    cliphist
    # wl-clipboard
    wl-clipboard-rs

    pyprland

  ];

  home.file.".config/hypr/pyprland.toml".source = ./pyprland.toml;

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
