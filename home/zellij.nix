{
  programs.zellij = {
    enable = true;
    settings.show_startup_tips = false;
    settings.keybinds = {
      normal = {
        "bind \"Alt Tab\"" = {
          FocusNextPane = [ ];
        };
        "bind \"Alt Shift Tab\"" = {
          FocusPreviousPane = [ ];
        };
        "bind \"Ctrl Tab\"" = {
          GoToNextTab = [ ];
        };
        "bind \"Ctrl Shift Tab\"" = {
          GoToPreviousTab = [ ];
        };
        "bind \"Alt Enter\"" = {
          ToggleFocusFullscreen = [ ];
        };
      };
    };
  };
}
