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
  config = mkIf config.programs.zsh.enable { users.defaultUserShell = pkgs.zsh; };
}
