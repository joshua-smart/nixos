{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{

  config = mkIf config.services.syncthing.enable {
    programs.git.ignores = [ ".stfolder/" ];
  };
}
