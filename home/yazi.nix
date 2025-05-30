{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
    '';
    shellWrapperName = "yy";
    plugins = with pkgs; {
      git = yaziPlugins.git;
      full-border = yaziPlugins.full-border;
    };

    # TODO: add more plugin seetings
    settings = {
      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
  };
}
