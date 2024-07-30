{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
{

  options.programs.discord.enable = mkEnableOption "discord";

  config = mkIf config.programs.discord.enable {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "discord";
        paths = with pkgs; [ discord ];
        buildInputs = with pkgs; [ makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/Discord \
            --add-flags "--disable-gpu"
        '';
      })
    ];
  };
}
