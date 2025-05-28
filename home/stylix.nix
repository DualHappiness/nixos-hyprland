{ pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";
    # image = builtins.fetchurl {
    #   url = "https://cdn.dynamicwallpaper.club/wallpapers/wqmsaakm50l/plants.heic";
    #   sha256 = "sha256-YQs7MBz8/hFT1Oy5pFr2xffl1jL9yvrA2w9N8Tp+IsA=";
    # };
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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/material-lighter.yaml";
    fonts = {
      sizes = {
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
}
