{
  description = "nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        laptop = lib.nixosSystem {
          inherit pkgs;
          inherit system;
          modules = [ ./hosts/laptop/configuration.nix ];
          specialArgs = { inherit pkgs-unstable; };
        };
      };
      homeConfigurations = {
        js = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./users/js/home.nix ];
          extraSpecialArgs = { inherit pkgs-unstable; };
        };
      };
    };
}
