{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batdiff
      batman
      batwatch
    ];
  };
}
