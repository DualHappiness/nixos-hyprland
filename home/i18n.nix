{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        (fcitx5-rime.override {
          rimeDataPkgs = with pkgs.nur.repos.linyinfeng.rimePackages; withRimeDeps [ rime-ice ];
        })
      ];
      waylandFrontend = true;
      settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "rime";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "rime";
      };
    };
  };
  home.file.".local/share/fcitx5/rime/default.custom.yaml".text = ''
    # in .local/share/fcitx5/rime/default.custom.yaml
    patch:
      __include: rime_ice_suggestion:/
      switcher/hotkeys:
        - "F4"
  '';
}
