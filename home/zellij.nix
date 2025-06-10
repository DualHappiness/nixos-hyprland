{
  home.file.".config/zellij/plugin/forgot.wasm".source = builtins.fetchurl {
    url = "https://github.com/karimould/zellij-forgot/releases/download/0.4.2/zellij_forgot.wasm";
    sha256 = "31194145519dbdc128685b456f970374378fa19fc9da742fbe4a321bace449db";
  };
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
        "bind \"Alt x\"" = {
          CloseFocus = [ ];
        };
        "bind \"Ctrl y\"" = {
          "LaunchOrFocusPlugin \"file:~/.config/zellij/plugin/forgot.wasm\"" = {
            "floating" = true;
          };
        };
      };
    };
  };
}
