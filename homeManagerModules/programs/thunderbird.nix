{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.thunderbird.enable {
    programs.thunderbird = {
      profiles.personal = {
        isDefault = true;
      };
    };
  };
}
