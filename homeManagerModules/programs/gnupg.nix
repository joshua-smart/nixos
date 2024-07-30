{ pkgs, config, lib, ... }: with lib;
{

  config = mkIf config.programs.gpg.enable {
    services.gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
}
