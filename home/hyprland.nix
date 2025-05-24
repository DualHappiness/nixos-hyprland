{ pkgs, ... }:
{
  programs.kitty.enable = true;
  programs.alacritty = {
    enable = true;
    settings = {
      window.blur = true;
      font.normal.family = "Maple Mono NF";
      # font.size = 14;
    };
  };


  programs.tofi.enable = true;
  home.file.".config/tofi/config".source = ./tofi.config;

  programs.waybar.enable = true;
  home.file.".config/waybar/config".source = ./waybar.config.json;
  home.file.".config/waybar/style.css".source = ./waybar.css;

  home.packages = with pkgs; [
    hyprls
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
