{ pkgs, ... }: {
  home.packages = [
    pkgs.symlinkJoin
    {
      name = "discord";
      paths = [ pkgs.discord ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/Discord \
          --add-flags "--disable-gpu"
      '';
    }
  ];
}
