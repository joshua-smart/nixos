{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.services.udiskie.enable {
    services.udiskie = {
      tray = "auto";
    };
  };
}
