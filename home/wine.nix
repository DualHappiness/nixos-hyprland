{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # # support both 32-bit and 64-bit applications
    # wineWowPackages.stable
    # winetricks (all versions)
    winetricks
    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];
}
