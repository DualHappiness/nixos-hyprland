{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 10;
        hide_cursor = true;
      };
      background = {
        path = "screenshot";
        blur_passes = 3;
      };
    };
  };
}
