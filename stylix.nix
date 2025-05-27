{ pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";
    # image = builtins.fetchurl {
    #   url = "https://cdn.dynamicwallpaper.club/wallpapers/wqmsaakm50l/plants.heic";
    #   sha256 = "sha256-YQs7MBz8/hFT1Oy5pFr2xffl1jL9yvrA2w9N8Tp+IsA=";
    # };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-light.yaml";
    fonts = {
      sizes.popups = 16;
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

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

}
