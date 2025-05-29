{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lxgw-neoxihei
    lxgw-wenkai
    lxgw-wenkai-screen

    maple-mono.NF

    sarasa-gothic

    source-han-sans
    source-han-serif
    jetbrains-mono
  ];
}
