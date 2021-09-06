{ stdenv, fetchurl, undmg, unzip }:

let
  pname = "Rectangle";
  version = "0.48";
  sha256 = "f85aa0db1efd9c5f455a0c8baed2b00ae506664711fe26a4f21cb1b4344e110a";
in
stdenv.mkDerivation {
  inherit pname version sha256;

  name = "${pname}-${version}";
  buildInputs = [ undmg unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "${pname}.app" "$out/Applications/${pname}.app"
    '';

  src = fetchurl {
    name = "${pname}-${version}.dmg";
    url = "https://github.com/rxhanson/Rectangle/releases/download/v${version}/Rectangle${version}.dmg";
    sha256 = "${sha256}";
  };
}
