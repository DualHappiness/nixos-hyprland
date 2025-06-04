{ pkgs, ... }:
let
  theme = "tomorrow";
in
{
  stylix = {
    enable = true;
    polarity = "dark";
    cursor = {
      name = "catppuccin-mocha-mavue-cursors";
      package = pkgs.catppuccin-cursors.mochaMauve;
      size = 32;
    };
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus Light";
      dark = "Papirus Dark";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
    opacity = {
      terminal = 0.85;
      popups = 0.95;
    };
    fonts = {
      sizes = {
        applications = 14;
        terminal = 12;
        popups = 16;
      };
      serif = {
        package = pkgs.sarasa-gothic;
        name = "Sarasa UI SC";
      };

      sansSerif = {
        package = pkgs.sarasa-gothic;
        name = "Sarasa UI SC";
      };

      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
    };
  };
  stylix.targets.waybar.enable = false;
}
