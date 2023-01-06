{
  description = "The configuration for my work systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-cfg = {
      url = "github:fxttr/emacs-cfg";
      flake = false;
    };
    artwork = {
      url = "github:NixOS/nixos-artwork";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, emacs-cfg, artwork, ... }@inputs: rec {
    legacyPackages = nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system:
      import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      }
    );

    nixosConfigurations = {
      workstation = nixpkgs.lib.nixosSystem {
        pkgs = legacyPackages.x86_64-linux;
        specialArgs = { inherit inputs; };
        modules = [ 
          ./nixos/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "florian@workstation" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
