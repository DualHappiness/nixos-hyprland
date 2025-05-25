{ pkgs, ... }:
{

  home.pointerCursor = {
    enable = true;
    name = "catppuccin-mocha-mavue-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    hyprcursor.enable = true;
    gtk.enable = true;
  };
}
