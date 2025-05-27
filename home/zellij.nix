{...}: {
  programs.zellij = {
    enable = true;
    settings = {
      show_startup_tips = false;
      themes = {
        catppuccin-latte = {
          bg = "#acb0be";
          fg = "#acb0be";
          red = "#d20f39";
          green = "#40a02b";
          blue = "#1e66f5";
          yellow = "#df8e1d";
          magenta = "#ea76cb";
          orange = "#fe640b";
          cyan = "#04a5e5";
          black = "#dce0e8";
          white = "#4c4f69";
        };
      };
      # theme = "catppuccin-latte";
    };
  };
}
