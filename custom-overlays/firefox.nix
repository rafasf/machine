{ stdenv, fetchurl, undmg, unzip }:

let
  pname = "Firefox";
  version = "91.0.2";
  sha256 = "e8d112ce9bd26d9eadf1ecb84256cb9646440a55d4ef4594c5d28a168b254067";
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
