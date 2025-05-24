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
    nu_scripts = {
      flake = false;
      url = "git+file:./home/nu_scripts";
    };
    catppuccin-gitui = {
      flake = false;
      url = "git+file:./home/catppuccin-gitui";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      version = "25.05";
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit version;
          inherit pkgs-unstable;
        } // inputs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = inputs;
            home-manager.backupFileExtension = "bakcup";
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.root = {
              home.stateVersion = version;
              imports = [ ./home.nix ];
            };
            home-manager.users.dual = {
              home.stateVersion = version;
              imports = [ ./home.nix ];
            };
          }

          # ./gnome.nix
          ./display-manager.nix
          ./hyprland.nix
        ];
      };
    };
}
