{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { inputs, ... }:
      {
        imports = [
          inputs.home-manager.flakeModules.home-manager
          (inputs.import-tree.matchNot ".*/hardware-configuration.nix" ./hosts)
          (inputs.import-tree ./modules)
          (inputs.import-tree ./pkgs)
        ];
        systems = [ "x86_64-linux" ];
        perSystem =
          {
            pkgs,
            inputs',
            ...
          }:
          {
            devShells.default = pkgs.mkShell {
              packages = [ inputs'.agenix.packages.default ];
            };
          };
      }
    );
}
# {
#   outputs =
#     {
#       nixpkgs,
#       nixpkgs-unstable,
#       home-manager,
#       agenix,
#       nix-index-database,
#       ...
#     }@inputs:
#     let
#       system = "x86_64-linux";
#       lib = nixpkgs.lib;

#       pkgs = import nixpkgs {
#         inherit system;
#         config.allowUnfree = true;
#         overlays = [
#           (final: prev: {
#             unstable = import nixpkgs-unstable {
#               inherit system;
#               config.allowUnfree = true;
#             };
#             myPackages = lib.filesystem.packagesFromDirectoryRecursive {
#               callPackage = final.callPackage;
#               directory = ./pkgs;
#             };
#           })
#         ];
#       };

#       myNixosSystem =
#         host:
#         lib.nixosSystem {
#           inherit pkgs system;
#           modules = [
#             ./hosts/${host}/configuration.nix
#             agenix.nixosModules.default
#           ];
#           specialArgs = {
#             inherit host inputs;
#           };
#         };

#       myHomeManagerConfiguration =
#         user: host:
#         home-manager.lib.homeManagerConfiguration {
#           inherit pkgs;
#           modules = [
#             ./hosts/${host}/home.nix
#             agenix.homeManagerModules.default
#             nix-index-database.homeModules.default
#           ];
#           extraSpecialArgs = {
#             inherit
#               user
#               host
#               inputs
#               ;
#           };
#         };
#     in
#     {
#       nixosConfigurations = {
#         laptop = myNixosSystem "laptop";
#         desktop = myNixosSystem "desktop";
#       };
#       homeConfigurations = {
#         "js@laptop" = myHomeManagerConfiguration "js" "laptop";
#         "js@desktop" = myHomeManagerConfiguration "js" "desktop";
#       };
# }
