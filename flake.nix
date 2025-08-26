{
  description = "joshua-smart nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      agenix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          })
          (final: prev: {
            myPackages = lib.filesystem.packagesFromDirectoryRecursive {
              callPackage = final.callPackage;
              directory = ./pkgs;
            };
          })
        ];
      };

      myNixosSystem =
        host:
        lib.nixosSystem {
          inherit pkgs system;
          modules = [
            ./hosts/${host}/configuration.nix
            agenix.nixosModules.default
          ];
          specialArgs = {
            inherit host inputs;
          };
        };

      myHomeManagerConfiguration =
        user: host:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/${host}/home.nix
            agenix.homeManagerModules.default
          ];
          extraSpecialArgs = {
            inherit
              user
              host
              inputs
              ;
          };
        };
    in
    {
      nixosConfigurations = {
        laptop = myNixosSystem "laptop";
        desktop = myNixosSystem "desktop";
        isoimage = myNixosSystem "isoimage";
      };
      homeConfigurations = {
        "js@laptop" = myHomeManagerConfiguration "js" "laptop";
        "js@desktop" = myHomeManagerConfiguration "js" "desktop";
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = [ agenix.packages.${system}.default ];
      };
    };
}
