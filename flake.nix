{
  description = "pure nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:DualHappiness/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nu_scripts = {
      flake = false;
      url = "github:nushell/nu_scripts";
    };
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      stylix,
      nur,
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
          stylix.homeModules.stylix
          ./home.nix
        ];
      };
      attrs = {
        inherit version;
        inherit pkgs-unstable;
      } // inputs;
    in
    {
      nixosConfigurations.panda-knight = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = attrs;
        modules = [
          ./configuration.nix
          # nur config
          { nixpkgs.overlays = [ nur.overlays.default ]; }

          home-manager.nixosModules.home-manager
          # home manager global config
          {
            home-manager.extraSpecialArgs = attrs;
            # home-manager.backupFileExtension = "bakcup";
            home-manager.useGlobalPkgs = true;
            # home-manager.users.root = home-config;
            home-manager.users.dual = home-config;
          }
          # ./gnome.nix
          ./display-manager.nix
          ./hyprland.nix
        ];
      };
    };
}
