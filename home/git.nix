{
  home.file.".config/git/delta.themes.gitconfig".source = ./delta.themes.gitconfig;
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "dualwu";
    userEmail = "dualwu_tech@outlook.com";
    extraConfig = {
      core = {
        editor = "vim";
      };
      safe = {
        directory = "/etc/nixos";
      };
      push = {
        autoSetupRemote = true;
      };
      include = {
        path = "~/.config/git/delta.themes.gitconfig";
      };
    };
    delta = {
      enable = true;
      options = {
        line-number = true;
        side-by-side = true;
        features = "zebra-light";
      };
    };
  };
  programs.gh.enable = true;
  programs.gitui.enable = true;
}
