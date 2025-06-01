{
  lib,
  config,
  pkgs,
  nu_scripts,
  ...
}:
{
  programs.bash = {
    enable = false;
    bashrcExtra = ''
      export WINDOWS_HOST=127.0.0.1
      export PROXY_PORT=44333
      export RUSTUP_DIST_SERVER="https://rsproxy.cn"
      export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
      alias ls=lsd
      export EDITOR=hx
    '';
  };
  programs.tealdeer.enable = true;

  programs.zoxide = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableNushellIntegration = true;
    enableFishIntegration = true;
  };
  programs.fzf.enable = true;
  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    settings = {
      inline_height = 10;
    };
  };

  # nushell
  home.file.".config/nushell/nu_scripts" = {
    source = nu_scripts;
    recursive = true;
  };
  programs.nushell = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      vim = "hx";
      vi = "hx";
      grep = "rg";
      cat = "bat";
      ze = "zellij";
      top = "btop";
    };
    environmentVariables = {
      EDITOR = "hx";
      BUILDAH_FORMAT = "docker";
    };
    extraEnv = lib.mkBefore ''
      $env.ENV_CONVERSIONS = {
        "PATH": {
            from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
            to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
        "Path": {
            from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
            to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
      }
    '';
    extraConfig = ''
      $env.config.show_banner = false

      const nu_scripts = "~/.config/nushell/nu_scripts"
      const nu_completions = $"($nu_scripts)/custom-completions"
      use $"($nu_completions)/nix/nix-completions.nu" *
      use $"($nu_completions)/bat/bat-completions.nu" *
      use $"($nu_completions)/cargo/cargo-completions.nu" *
      use $"($nu_completions)/curl/curl-completions.nu" *
      use $"($nu_completions)/docker/docker-completions.nu" *
      use $"($nu_completions)/gh/gh-completions.nu" *
      use $"($nu_completions)/git/git-completions.nu" *
      use $"($nu_completions)/just/just-completions.nu" *
      use $"($nu_completions)/less/less-completions.nu" *
      use $"($nu_completions)/nix/nix-completions.nu" *
      use $"($nu_completions)/rg/rg-completions.nu" *
      use $"($nu_completions)/rustup/rustup-completions.nu" *
      use $"($nu_completions)/ssh/ssh-completions.nu" *
      use $"($nu_completions)/tar/tar-completions.nu" *
      use $"($nu_completions)/tealdeer/tldr-completions.nu" *
      use $"($nu_completions)/zellij/zellij-completions.nu" *

      $env.config.edit_mode = "vi";
      $env.config.cursor_shape.vi_insert = "line";
      $env.config.cursor_shape.vi_normal = "block";

      source ~/.config/nushell/locals.nu

      fastfetch
    '';
  };
}
