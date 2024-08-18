{ config, lib, ... }:
with lib;
{
  options.profiles.power-management.enable = mkEnableOption "power management profile";

  config = mkIf config.profiles.power-management.enable {
    powerManagement = {
      enable = true;
      powertop.enable = true;
    };
    services.thermald.enable = true;
    services.tlp.enable = true;
  };
}
