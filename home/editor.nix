{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  home.packages =
    (with pkgs-unstable; [
      code-cursor
      zed-editor
      vscode
    ])
    ++ (with pkgs; [
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

      nixfmt-rfc-style
      rustup
    ]);

  programs.helix = {
    enable = true;
    package = pkgs-unstable.helix;
    defaultEditor = true;
    extraConfig = builtins.readFile ./helix.config.toml;
    languages = {
      language = [
        {
          name = "nix";
          formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
          auto-format = true;
        }
      ];
    };
  };
}
