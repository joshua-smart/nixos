{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.games.enable = mkEnableOption "games profile";

  config = mkIf config.profiles.games.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
