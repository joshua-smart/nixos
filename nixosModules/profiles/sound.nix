{ config, lib, ... }:
with lib;
{
  options.profiles.sound.enable = mkEnableOption "sound profile";

  config = mkIf config.profiles.sound.enable {
    # Enable sound with pipewire.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}
