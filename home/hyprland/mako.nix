{
  services.mako = {
    enable = true;
    settings = {
      sort = "-time";
      layer = "overlay";
      width = 450;
      height = 150;
      border-size = 1;
      border-radius = 12;
      icons = 1;
      max-icon-size = 64;
      default-timeout = 5000;
      ignore-timeout = 0;
      margin = 12;
      padding = "12,20";

      # NOTE: stylix work wrong with font size
      # font = lib.mkForce "Sarasa Term SC 16";

      "urgency=critical" = {
        default-timeout = 0;
      };

    };
  };
}
