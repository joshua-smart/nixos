{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.power-management.enable = mkEnableOption "power management profile";

  config = mkIf config.profiles.power-management.enable {
    powerManagement.enable = true;
    services.thermald.enable = true;
    services.tlp.enable = true;
  };
}
