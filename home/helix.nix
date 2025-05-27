{pkgs, ...}: {
  programs.helix.enable = true;
  programs.helix.defaultEditor = true;
  programs.helix.extraConfig = builtins.readFile ./helix.config.toml;
  home.packages = with pkgs; [
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
    nixd
  ];
}
