{lib, pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home.file.".npmrc".source = ./.npmrc;
  home.packages = with pkgs; [nodejs github-copilot-cli];
  programs.nushell.extraEnv = lib.mkAfter ''
    $env.PATH = $env.PATH | append "~/.npm-packages/bin"
    $env.NODE_PATH = "~/.npm-packages/lib/node_modules"
  '';
  programs.bash.initExtra = lib.mkAfter ''
    export PATH=~/.npm-packages/bin:$PATH
    export NODE_PATH=~/.npm-packages/lib/node_modules
    eval "$(github-copilot-cli alias -- "$0")"
  '';
}
