{ pkgs, ... }:
{
  # nixpkgs.overlays = [
  #   (self: super: {
  #     feishu = super.feishu.overrideAttrs (oldAttrs: {
  #       nativeInputs = (oldAttrs.nativeInputs or [ ]) ++ [ self.makeWrapper ];
  #       installPhase =
  #         (oldAttrs.installPhase or "")
  #         + ''
  #           wrapProgram $out/bin/bytedance-feishu \
  #             --set GTK_IM_MODULE "fcitx"
  #         '';
  #     });
  #   })
  # ];

  home.packages = [ pkgs.feishu ];
}
