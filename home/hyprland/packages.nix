{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pulseaudio
    brightnessctl

    hyprls
    iwgtk
    blueberry
    grim
    slurp

    wl-clipboard
    # wl-clipboard-rs
    nautilus
  ];

}
