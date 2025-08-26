{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.direnv.enable {
    programs.direnv = {
      enableZshIntegration = true;

      nix-direnv.enable = true;

      stdlib = ''
        export DIRENV_ACTIVE=1
      '';

      silent = true;
    };
  };
}
