{ config, lib, ... }:
with lib;
{
  config = mkIf config.services.udiskie.enable {
    services.udiskie = {
      tray = "auto";
    };
  };
}
