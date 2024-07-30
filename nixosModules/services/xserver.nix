{ config, lib, pkgs, ... }: with lib;
{
  config = mkIf config.services.xserver.enable {
    services.xserver.excludePackages = with pkgs; [ xterm ];
  };
}