{
  description = "joshua-smart nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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
    }:
    let
      system = "x86_64-linux";

      lib = nixpkgs.lib;

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (final: prev: { unstable = pkgs-unstable; }) ];
      };

      myNixosSystem =
        host:
        lib.nixosSystem {
          inherit pkgs;
          inherit system;
          modules = [
            ./hosts/${host}/configuration.nix
            agenix.nixosModules.default
          ];
          specialArgs = {
            inherit host;
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
            inherit user host;
          };
        };
    in
    {
      nixosConfigurations = {
        laptop = myNixosSystem "laptop";
        desktop = myNixosSystem "desktop";
        server = myNixosSystem "server";
        isoimage = myNixosSystem "isoimage";
      };
      homeConfigurations = {
        "js@laptop" = myHomeManagerConfiguration "js" "laptop";
        "js@desktop" = myHomeManagerConfiguration "js" "desktop";
        "js@server" = myHomeManagerConfiguration "js" "server";
      };
    };
}
