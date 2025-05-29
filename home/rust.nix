{ pkgs, ... }:
{
  home.file.".cargo/config.toml".source = ./cargo.config.toml;
  home.packages = with pkgs; [
    git
    rustup
    mold
    cargo-cross
  ];
  programs.nushell.extraEnv = ''
    $env.RUSTUP_DIST_SERVER = "https://rsproxy.cn"
    $env.RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup"
  '';
  programs.bash.initExtra = ''
    export RUSTUP_DIST_SERVER="https://rsproxy.cn"
    export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
  '';
}
