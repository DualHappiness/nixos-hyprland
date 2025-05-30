{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hurl
    fd
    hyperfine
    tokei
    rancher
    kubectl
    translate-shell
    autossh

    cmake
    ninja
    clang
    bazel-buildtools
    ansible-lint

    du-dust
    shfmt
    wslu

    alejandra
    just
    viu
    termscp
  ];
}
