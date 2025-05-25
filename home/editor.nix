{ pkgs-unstable, ... }:
{
  home.packages = with pkgs-unstable; [
    code-cursor
    zed-editor
    vscode
  ]; 
}
