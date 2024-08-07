{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";

    flake-utils.url = "github:numtide/flake-utils";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      flake-utils,
      agenix,
      rust-overlay,
      ...
    }@inputs:
    with flake-utils.lib;
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs defaultSystems;
    in
    {
      nixosConfigurations = {
        acedia = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };

          modules = [
            ./nixos/configuration.nix
            agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.santos = import ./home/santos.nix;
            }
          ];
        };
      };

      homeConfigurations = {
        santos = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./home/santos.nix ];
        };
      };

      overlays = import ./overlays { inherit inputs outputs; };

      nixosModules = import ./modules/nixos;

      packages = forAllSystems (
        system:
        import ./pkgs (
          (import nixpkgs) {
            inherit system;
            overlays = [ (import rust-overlay) ];
          }
        )
      );

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
