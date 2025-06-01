{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        rime-data
        fcitx5-gtk
        fcitx5-rime
        fcitx5-chinese-addons
        fcitx5-material-color
        fcitx5-pinyin-zhwiki
        fcitx5-pinyin-moegirl
      ];
      waylandFrontend = true;
      enableRimeData = true;
    };
  };

}
