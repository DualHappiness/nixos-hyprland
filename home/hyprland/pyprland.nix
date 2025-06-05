{ pkgs, ... }:
{
  home.packages = [ pkgs.pyprland ];
  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
     "scratchpads",
    ]

    # using variables for demonstration purposes (not needed)
    [pyprland.variables]
    term_classed = "alacritty --class"

    [scratchpads.term]
    animation = "fromTop"
    command = "[term_classed] main-dropterm"
    class = "main-dropterm"
    size = "80% 70%"
    max_size = "100% 100%"
  '';
}
