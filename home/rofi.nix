{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,filebrowser,run";
      show-icons = true;
      icon-theme = "Papirus";
      font = "Mapl Mono NF 12";
      drun-display-format = "{icon} {name}";
      display-drun = " Apps";
      display-run = " Run";
      display-filebrowser = " File";
    };
    theme = lib.mkAfter (
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        "window" = {
          transparency = "real";
          width = mkLiteral "1000px";
          location = mkLiteral "center";
          anchor = mkLiteral "center";
          fullscreen = false;
          x-offset = mkLiteral "0px";
          y-offset = mkLiteral "0px";
          cursor = "default";
          enabled = true;
          border-radius = mkLiteral "15px";
        };
        "mainbox" = {
          enabled = true;
          spacing = mkLiteral "0px";
          orientation = mkLiteral "horizontal";
          children = map mkLiteral [
            "imagebox"
            "listbox"
          ];
          background-color = lib.mkForce (mkLiteral "transparent");
        };
        "imagebox" = {
          padding = mkLiteral "20px";
          background-color = lib.mkForce (mkLiteral "transparent");
          background-image = mkLiteral ''url("~/backgrounds/wallhaven-je9ldp.jpg", height)'';
          orientation = mkLiteral "vertical";
          children = map mkLiteral [
            "inputbar"
            "dummy"
            "mode-switcher"
          ];
        };
        "listbox" = {
          spacing = mkLiteral "20px";
          padding = mkLiteral "20px";
          background-color = lib.mkForce (mkLiteral "transparent");
          orientation = mkLiteral "vertical";
          children = map mkLiteral [
            "message"
            "listview"
          ];
        };
        "dummy" = {
          background-color = mkLiteral "transparent";
        };
        "inputbar" = {
          enabled = true;
          spacing = mkLiteral "10px";
          padding = mkLiteral "10px";
          border-radius = mkLiteral "10px";
          children = map mkLiteral [
            "textbox-prompt-colon"
            "entry"
          ];
        };
        "textbox-prompt-colon" = {
          enabled = true;
          expand = false;
          str = "";
        };
        "entry" = {
          enabled = true;
          background-color = mkLiteral "inherit";
          cursor = mkLiteral "text";
          placeholder = "Search";
          placeholder-color = mkLiteral "inherit";
        };
        "mode-switcher" = {
          enabled = true;
          spacing = mkLiteral "20px";
          background-color = lib.mkForce (mkLiteral "transparent");
        };
        "button" = {
          padding = mkLiteral "15px";
          border-radius = mkLiteral "10px";
          cursor = mkLiteral "pointer";
        };
        "listview" = {
          enabled = true;
          columns = 1;
          lines = 8;
          cycle = true;
          dynamic = true;
          scrollbar = false;
          layout = mkLiteral "vertical";
          reverse = false;
          fixed-height = true;
          fixed-columns = true;
          spacing = mkLiteral "10px";
          background-color = lib.mkForce (mkLiteral "transparent");
          cursor = "default";
        };
        "element" = {
          enabled = true;
          spacing = mkLiteral "15px";
          padding = mkLiteral "8px";
          border-radius = mkLiteral "10px";
          background-color = lib.mkForce (mkLiteral "transparent");
          cursor = mkLiteral "pointer";
        };
        "element-icon" = {
          background-color = lib.mkForce (mkLiteral "transparent");
          text-color = mkLiteral "inherit";
          size = mkLiteral "36px";
          cursor = mkLiteral "inherit";
        };
        "element-text" = {
          background-color = lib.mkForce (mkLiteral "transparent");
          text-color = mkLiteral "inherit";
          cursor = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
        };
        "message" = {
          background-color = lib.mkForce (mkLiteral "transparent");
        };
        "textbox" = {
          padding = mkLiteral "15px";
          border-radius = mkLiteral "10px";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
        };
        "error-message" = {
          padding = mkLiteral "15px";
          border-radius = mkLiteral "20px";
          text-color = mkLiteral "@foreground";
        };
      }
    );
  };

  home.file.".config/rofi/config-long.rasi".text = ''
    @import "~/.config/rofi/config.rasi"
    window {
      width: 750px;
      border-radius: 20px;
    }
    mainbox {
      orientation: vertical;
      children: [ "inputbar", "listbox" ];
    }
    inputbar {
      padding: 75px 40px;
      background-color: transparent;
      background-image: url("~/backgrounds/wallhaven-je9ldp.jpg", width);
      children: [ "textbox-prompt-colon", "entry" ];
    }
    textbox-prompt-colon {
      padding: 12px 20px;
      border-radius: 100%;
    }
    entry {
      expand: true;
      padding: 12px 16px;
      border-radius: 100%;
    }
    button {
      padding: 12px;
      border-radius: 100%;
    }
    element {
      spacing: 10px;
      padding: 12px;
      border-radius: 100%;
    }
    textbox {
      padding: 12px;
      border-radius: 100%;
    }
    error-message {
      border-radius: 0px;
    }
  '';

  home.packages = [
    (pkgs.writeShellScriptBin "rofi-launcher" ''
      # check if rofi is already running
      if pidof rofi > /dev/null; then
        pkill rofi
      fi
      rofi -show drun
    '')
  ];
}
