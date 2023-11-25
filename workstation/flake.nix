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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "github:fxttr/secrets";
      flake = false;
    };
    coco = {
      url = "github:fxttr/coco";
    };
    artwork = {
      url = "github:NixOS/nixos-artwork";
      flake = false;
    };
    xmonad = {
      url = "github:fxttr/xmonad-cfg";
    };
  };

  outputs = { self, nixpkgs, home-manager, emacs-cfg, sops-nix, secrets, coco, artwork, ... }@inputs: rec {
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
          sops-nix.nixosModules.sops
          coco.nixosModules.nixos
        ];
      };
    };

    homeConfigurations = {
      "florian@workstation" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home-manager/home.nix
          sops-nix.homeManagerModules.sops
          coco.nixosModules.home-manager
        ];
      };
    };
  };
}
