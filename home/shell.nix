{
  lib,
  config,
  pkgs,
  nu_scripts,
  ...
}: {
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
  programs.zsh = {
    enable = false;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    # syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "lsd";
      br = "broot";
    };
    envExtra = ''
      export EDITOR=hx
      export VI_MODE_SET_CURSOR=true
    '';
    oh-my-zsh = {
      enable = true;
      theme = "random";
      plugins = [
        "git"
        "extract"
        "z"
        "vi-mode"
        "history"
        "sudo"
        "emotty"
        "emoji"
        "vi-mode"
      ];
    };
  };
  programs.fish = {
    enable = false;
    shellAliases = {
      vim = "hx";
      ls = "lsd";
    };
    shellInit = ''
      set -g -x EDITOR hx
    '';
    functions = {
      proxy = ''
        set -g -x HTTP_PROXY "http://$WINDOWS_HOST:$PROXY_PORT"
        set -g -x HTTPS_PROXY "http://$WINDOWS_HOST:$PROXY_PORT"
        set -g -x http_proxy "http://$WINDOWS_HOST:$PROXY_PORT"
        set -g -x https_proxy "http://$WINDOWS_HOST:$PROXY_PORT"
      '';
      unproxy = ''
        set -g -e HTTP_PROXY
        set -g -e HTTPS_PROXY
        set -g -e http_proxy
        set -g -e https_proxy
      '';
    };
  };
  programs.tealdeer.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableNushellIntegration = true;
    enableFishIntegration = true;
  };
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

  # fastfetch
  programs.fastfetch = {
    enable = true;
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
      docker = "uwsm app -- docker";
      podman = "uwsm app -- podman";
      distrobox = "uwsm app -- distrobox";
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
      use $"($nu_completions)/docker/docker-completions.nu" *
      use $"($nu_completions)/curl/curl-completions.nu" *
      use $"($nu_completions)/less/less-completions.nu" *
      use $"($nu_completions)/bat/bat-completions.nu" *
      use $"($nu_completions)/gh/gh-completions.nu" *
      use $"($nu_completions)/git/git-completions.nu" *
      use $"($nu_completions)/rustup/rustup-completions.nu" *
      use $"($nu_completions)/cargo/cargo-completions.nu" *
      use $"($nu_completions)/rg/rg-completions.nu" *
      use $"($nu_completions)/zellij/zellij-completions.nu" *
      use $"($nu_completions)/tealdeer/tldr-completions.nu" *
      use $"($nu_completions)/ssh/ssh-completions.nu" *
      use $"($nu_completions)/just/just-completions.nu" *
      use $"($nu_completions)/gh/gh-completions.nu" *

      use $"($nu_scripts)/themes/nu-themes/material-vivid.nu"

      $env.WINDOWS_HOST = "127.0.0.1"
      $env.PROXY_PORT = 44333
      def --env proxy [] {
        $env.HTTP_PROXY = $"http://($env.WINDOWS_HOST):($env.PROXY_PORT)"
        $env.HTTPS_PROXY = $"http://($env.WINDOWS_HOST):($env.PROXY_PORT)"
        $env.http_proxy = $"http://($env.WINDOWS_HOST):($env.PROXY_PORT)"
        $env.https_proxy = $"http://($env.WINDOWS_HOST):($env.PROXY_PORT)"
      }
      def --env unproxy [] {
        hide-env HTTP_PROXY HTTPS_PROXY
        hide-env http_proxy https_proxy
      }
      $env.config.edit_mode = "vi";
      $env.config.cursor_shape.vi_insert = "line";
      $env.config.cursor_shape.vi_normal = "block";

      module podman {
        export def "images" [] {
          ^podman images | lines | skip 1 | parse -r '(?P<RESPOSITORY>\S+)\s+(?P<TAG>\S+)\s+(?P<ID>\S+)\s+(?P<CREATED>\d+ \w+ ago)\s+(?P<SIZE>.*)'
        }
        export def "containers" [] {
          let re = '(?P<CID>\S+)\s+(?P<IMAGE>\S+)\s+(?P<COMMAND>\S+)\s+(?P<CREATED>\d+ \w+ ago)\s+(?P<STATUS>Created|Exited \(\d+\) \d+ \w+ ago)\s*(?P<PORTS>.*tcp|.*udp|\s)\s*(?P<NAMES>\S+)\s*'
          ^podman container ls -a | lines | skip 1 | parse -r $re
        }
      }
      use podman *

      module copilot {
        export def "??" [...flags:string] {
          ^github-copilot-cli what-the-shell ($flags)
        }
        export def "git?" [...flags:string] {
          ^github-copilot-cli git-assist ($flags)
        }
        export def "gh?" [...flags:string] {
          ^github-copilot-cli gh-assist ($flags)
        }
      }
      use copilot *

      source ~/.config/nushell/locals.nu

      fastfetch -l nixos_old
    '';
  };
}
