{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.steam.enable {
    programs.steam = {
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;
  };
}
