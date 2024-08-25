{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.bluetooth.enable = mkEnableOption "bluetooth profile";

  config = mkIf config.profiles.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}
