{
  programs.broot = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      modal = true;
      verbs = [
        {
          invocation = "p";
          execution = ":parent";
        }
        {
          invocation = "open_stay";
          execution = "$EDITOR {file}";
        }
        {
          invocation = "edit";
          shortcut = "e";
          execution = "$EDITOR {file}";
        }
        {
          invocation = "create {subpath}";
          execution = "$EDITOR {directory}/{subpath}";
        }
        {
          invocation = "view";
          execution = "less {file}";
        }
      ];
    };
  };
}
