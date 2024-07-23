{ lib, config, ... }:
with lib;
let
  cfg = config.key-remapping;
in
{

  options.key-remapping = mkOption { type = types.lines; };

  config = {
    services.kanata = {
      enable = true;
      keyboards.main = {
        config = cfg;
      };
    };
  };
}
