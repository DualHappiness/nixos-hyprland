{ pkgs, ... }:
{
  home.packages = with pkgs; [
    feishu
    wechat-uos
  ];
}
