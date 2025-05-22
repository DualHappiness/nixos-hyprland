{
  description = "pure nixos";
  inputs = {
     nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
     nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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

  outputs = { nixpkgs, home-manager, ... } @ inputs:
  let
    version = "24.11";
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit version; } // inputs;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = inputs;
          nixpkgs.config.allowUnfree = true;
          home-manager.useGlobalPkgs = true;
          home-manager.users.root = {
            home.stateVersion = version;
            imports = [
              ./home.nix
            ];
          };
          home-manager.users.dual = {
            home.stateVersion = version;
            imports = [
              ./home.nix
            ];
          };
        }
      ];
    };
  };
}
