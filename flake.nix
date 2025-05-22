{
  description = "pure nixos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { nixpkgs, ... } @ attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { version = "24.11"; } // attrs;
      modules = [
        ./configuration.nix
      ];
    };
  };
}
