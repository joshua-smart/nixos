{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
  gtk3,
  ...
}:
stdenvNoCC.mkDerivation rec {
  pname = "monday-icon-theme";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "luisrguerra";
    repo = pname;
    rev = "96567eea9ddd87197160f5b147efbe14f2fb35e3";
    hash = "sha256-eUPLXYY3PXRs4pl7tTVIiCnVM/ecDrnZtka3NltJWmk=";
  };

  nativeBuildInputs = [ gtk3 ];

  dontDropIconThemeCache = true;
  dontBuild = true;
  dontPatchELF = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons/
    cp -r Monday $out/share/icons/
    runHook postInstall
  '';

  postFixup = # bash
    ''gtk-update-icon-cache $out/share/icons/Monday'';

  meta = with lib; {
    description = "Monday icon theme";
    homepage = "https://github.com/luisrguerra/monday-icon-theme";
    platforms = platforms.linux;
    license = licenses.gpl3Only;
    maintainers = [ ];
  };
}
