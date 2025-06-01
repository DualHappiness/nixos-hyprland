{
  wayland.windowManager.hyprland.settings = {
    layerrules = [
      # Layer Rules
      "blur, waybar"
      "ignorezero, waybar"
      "blur, notifications"
      "ignorezero, notifications"
      "blur, launcher"
      "ignorezero, launcher"
    ];

    windowrules = [
      # Window Rules
      "tile,class:(Alacritty)"
      "float,class:(QQ) # QQ Popups"
      "float,title:(Volume Control) # Volume Control"
      "float,class:(steam) # Steam Popups"
      "float,title:(Qt5 Configuration Tool) # Qt5"
      "float,title:(Qt6 Configuration Tool) # Qt6"
      "float,title:(Fcitx Configuration) # Fcitx Config"
      "float,class:(org.gnome.Nautilus) # Nautilus Popups"
      "float,class:(firefox),title:(Library) # Firefox Popups"
      "float,class:(vlc) # VLC Popups"
      "float,class:(qemu.*) # QEMU"
      "float,class:(org.telegram.desktop),title:(Media viewer)"
      "float,class:(Bytedance-feishu)"
      "float,title:(飞书会议)"
      "float,class:(com.st.app.Main)"
      "float,class:(ltspice.exe)"
      "float,class:(blueberry.py)"
      "float,class:(*iwgtk)"
      "float,title:(iwgtk)"
      # always render
      "renderunfocused,class:(vseeface.exe)"
      # immediate render
      "immediate, class:^(cs2)$"

    ];
  };
}
