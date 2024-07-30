{ config, lib, pkgs, ... }: with lib; {
  config = mkIf config.programs.zsh.enable {
    users.defaultUserShell = pkgs.zsh;
  };
}