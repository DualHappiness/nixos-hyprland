{ pkgs, ... }:

{
  # Enable Display Manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time --time-format '%I:%M %p | %a • %h | %F' \
          -g NixOS \
          --remember --remember-session --kb-power 12 \
          --cmd 'uwsm start hyprland'
        '';
      };
    };
  };

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  # NOTE: issus closed but problem still happen
  # https://github.com/NixOS/nixpkgs/issues/248323
  systemd.tmpfiles.rules = [
    "d '/var/cache/tuigreet' - greeter greeter - -"
  ];
}
