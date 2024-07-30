{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.profiles.games.enable = mkEnableOption "games profile";

  config = mkIf config.profiles.games.enable {
    home.packages = with pkgs; [
      prismlauncher
      lutris
    ];
  };
}
