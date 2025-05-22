{pkgs, catppuccin-gitui, ...}: {
  home.file.".config/git/delta.themes.gitconfig".source = ./delta.themes.gitconfig;
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "dualwu";
    userEmail = "dualwu_tech@outlook.com";
    extraConfig = {
      core = {editor = "hx";};
      safe = {directory = "/etc/nixos";};
      push = {autoSetupRemote = true;};
      include = {path = "~/.config/git/delta.themes.gitconfig";};
    };
    delta = {
      enable = true;
      options = {
        line-number = true;
        side-by-side = true;
        features = "zebra-dark";
      };
    };
  };
  programs.gh.enable = true;

  programs.gitui.enable = true;
  programs.gitui.theme = builtins.readFile "${catppuccin-gitui}/themes/catppuccin-latte.ron";
  home.file.".config/gitui" = {
    source = "${catppuccin-gitui}/themes";
    recursive = true;
  };
}
