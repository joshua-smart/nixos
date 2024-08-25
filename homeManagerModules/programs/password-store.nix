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

  config = mkIf config.programs.password-store.enable {
    home.packages = with pkgs; [ wl-clipboard ];

    programs.gpg.enable = true;
  };
}
