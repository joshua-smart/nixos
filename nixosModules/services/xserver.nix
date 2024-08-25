{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.services.xserver.enable {
    services.xserver.excludePackages = with pkgs; [ xterm ];
  };
}
