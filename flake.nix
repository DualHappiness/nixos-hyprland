{
  description = "pure nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-2505.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland/v0.49.0";
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
      version = "24.11";
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-2505= import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit version;
          inherit pkgs-unstable;
          inherit pkgs-2505;
        } // inputs;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = inputs;
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
        ];
      };
    };
}
