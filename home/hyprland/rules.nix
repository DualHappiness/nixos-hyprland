{
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      # Layer Rules
      "blur, waybar"
      "ignorezero, waybar"
      "blur, notifications"
      "ignorezero, notifications"
      "blur, launcher"
      "ignorezero, launcher"
    ];

    windowrulev2 = [
      # Window Rules
      "tile,class:(Alacritty)"
      "float,class:(Alacritty-Popups)"
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
      "float,class:^(Bytedance-feishu)$"
      "tile,class:^(Bytedance-feishu)$,title:^(飞书)$"
      "float,title:(飞书会议)"
      "float,class:(com.st.app.Main)"
      "float,class:(ltspice.exe)"
      "float,class:(blueberry.py)"
      "float,class:(*iwgtk)"
      "float,title:(iwgtk)"
      "float,class:(xdg-desktop-portal-gtk)"
      "float,class:(wechat)"
      # always render
      "renderunfocused,class:(vseeface.exe)"
      # immediate render
      "immediate, class:^(cs2)$"
    ];
  };
}
