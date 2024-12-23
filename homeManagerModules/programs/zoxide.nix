{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.zoxide.enable {
    programs.zoxide = {
      options = [ "--cmd cd" ];
    };
  };
}
