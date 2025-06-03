{
  programs.zellij = {
    enable = true;
    settings.show_startup_tips = false;
    settings.keybinds = {
      normal = {
        "bind \"Ctrl Tab\"" = {
          FocusNextPane = [ ];
        };
        "bind \"Ctrl Shift Tab\"" = {
          FocusPreviousPane = [ ];
        };
        "bind \"Alt Tab\"" = {
          GoToNextTab = [ ];
        };
        "bind \"Alt Shift Tab\"" = {
          GoToPreviousTab = [ ];
        };
      };
    };
  };
}
