{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{

  options.scripts.enable = mkEnableOption "scripts";

  config = mkIf config.scripts.enable {
    home.packages = [
      (pkgs.callPackage ./unlink-keep.nix { })
      (pkgs.callPackage ./gtree.nix { })
    ];
  };
}
