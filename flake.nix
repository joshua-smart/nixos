{
  description = "joshua-smart nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      sops-nix,
      nix-index-database,
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
            sops-nix.nixosModules.sops
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
            sops-nix.homeManagerModules.sops
            nix-index-database.homeModules.default
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
      };
      homeConfigurations = {
        "js@laptop" = myHomeManagerConfiguration "js" "laptop";
        "js@desktop" = myHomeManagerConfiguration "js" "desktop";
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.ssh-to-age
          pkgs.age
          pkgs.sops
        ];
      };
    };
}
