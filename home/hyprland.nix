{ pkgs, ... }:
{
  programs.kitty.enable = true;
  programs.alacritty.enable = true;  

  programs.tofi.enable = true;
  home.file.".config/tofi/config".source = ./tofi.config;
  
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
        
