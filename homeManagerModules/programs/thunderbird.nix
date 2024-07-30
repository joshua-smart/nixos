{ config, lib, ... }:
with lib;
{
  config = mkIf config.programs.thunderbird.enable {
    programs.thunderbird = {
      profiles.personal = {
        isDefault = true;
      };
    };
  };
}
