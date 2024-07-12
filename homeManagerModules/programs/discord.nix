{ pkgs, ... }:
{
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
}
