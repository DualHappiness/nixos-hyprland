{pkgs, ...}: {
  programs.helix.enable = true;
  home.file = {
    ".config/helix/config.toml".source = ./helix.config.toml;
  };
  home.packages = with pkgs; [
    nil
    taplo
    nodePackages.vscode-langservers-extracted
    terraform-ls
    clang-tools
    nodePackages.bash-language-server
    marksman
    python311Packages.python-lsp-server
    yaml-language-server
    cmake-language-server
    lua-language-server
  ];
}
