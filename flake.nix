{
  description = "pure nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nu_scripts = {
      flake = false;
      url = "git+file:./home/nu_scripts";
    };
    catppuccin-gitui = {
      flake = false;
      url = "git+file:./home/catppuccin-gitui";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      version = "25.05";
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      home-config = {
        home.stateVersion = version;
        imports = [
          inputs.zen-browser.homeModules.beta
          ./home.nix
        ];
      };
      attrs = {
        inherit version;
        inherit pkgs-unstable;
      } // inputs;
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = attrs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = attrs;
            home-manager.backupFileExtension = "bakcup";
            home-manager.useGlobalPkgs = true;
            home-manager.users.root = home-config;
            home-manager.users.dual = home-config;
          }

          # ./gnome.nix
          ./display-manager.nix
          ./hyprland.nix
        ];
      };
    };
}
