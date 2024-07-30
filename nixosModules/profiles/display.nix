{ config, lib, ... }:
with lib;
{
  options.profiles.display.enable = mkEnableOption "display profile";

  config = mkIf config.profiles.display.enable {

    programs.light.enable = true;
    programs.hyprland.enable = true;
    services.displayManager.sddm.enable = true;
    services.xserver.enable = true;
  };
}
