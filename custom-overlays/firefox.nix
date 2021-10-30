{ stdenv, fetchurl, undmg, unzip }:

let
  pname = "Firefox";
  version = "93.0";
  sha256 = "31df9384a4c01b5fba9f3b7e2355b8ea1cd122bd71b36e4a0341c9d237701342";
in
stdenv.mkDerivation {
  inherit pname version sha256;

  name = "${pname}-${version}";
  buildInputs = [ undmg unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r Firefox.app "$out/Applications/Firefox.app"
    '';

  src = fetchurl {
    name = "Firefox-${version}.dmg";
    url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-GB/Firefox%20${version}.dmg";
    sha256 = "${sha256}";
  };
}
