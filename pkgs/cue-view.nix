{ appimageTools, fetchurl }:
appimageTools.wrapType2 rec {
  pname = "cue-view";
  version = "1.3.0";
  src = fetchurl {
    url = "https://github.com/stagehacks/Cue-View/releases/download/v${version}/cue-view.linux-x86_64.v${version}.AppImage";
    sha256 = "sha256-uR170/eq/nYVQSuvSpno0bkDMGAKJ6xkqlWbvzRernI=";
  };

  extraInstallCommands =
    let
      appimageContents = appimageTools.extract { inherit pname version src; };
    in
    /* bash */ ''
      install -Dm444 ${appimageContents}/cue-view.desktop -t $out/share/applications/
      install -Dm444 ${appimageContents}/cue-view.png -t $out/share/icons/hicolor/512x512/apps/

      substituteInPlace $out/share/applications/cue-view.desktop \
        --replace-fail 'Exec=AppRun --no-sandbox' 'Exec=${pname}'
    '';
}
