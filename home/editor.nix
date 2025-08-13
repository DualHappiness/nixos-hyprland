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
      zed-editor-fhs
      vscode
      warp-terminal
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

      vscode-extensions.vadimcn.vscode-lldb
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

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        max_line_width = 100;
        indent_style = "space";
        indent_size = 4;
      };
    };
  };
}
