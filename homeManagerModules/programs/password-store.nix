{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
{

  config = mkIf config.programs.password-store.enable {
    home.packages = with pkgs; [ wl-clipboard ];

    programs.gpg.enable = true;
  };
}
