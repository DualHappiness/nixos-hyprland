{ config, pkgs,  ... }:
let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    requests
  ]);
  scriptPath = "${config.home.homeDirectory}/.cache/dailybing.py";
in
{
  home.file.".cache/dailybing.py".source = ./dailybing.py;
  systemd.user.services.dailybing = {
    Unit = {
      Description = "daily bing fetcher";
      After = [ "network-online.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pythonEnv}/bin/python ${scriptPath}";
      WorkingDirectory = "${config.home.homeDirectory}";
    };
  };

  systemd.user.timers.dailybing = {
    Unit = {
      Description = "dailybing timer";
    };
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
