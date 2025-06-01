{
  imports = [
    ./dailybing.nix
  ];
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/backgrounds/current.jpg" ];
      wallpaper = [ ",~/backgrounds/current.jpg" ];
    };
  };
}
