{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
in
{

  config = mkIf config.programs.gpg.enable {
    services.gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}
