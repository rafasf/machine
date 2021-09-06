{ stdenv, fetchurl, undmg, unzip }:

let
  pname = "Alfred";
  version = "4.5.1_1256";
  sha256 = "cc2066d1c6d057e3ecb12485763bef2d076ad21de8fd27ebbd6452dbaf3a1344";
in
stdenv.mkDerivation {
  inherit pname version sha256;

  name = "${pname}-${version}";
  buildInputs = [ undmg unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "${pname} 4.app" "$out/Applications/${pname}.app"
    '';

  src = fetchurl {
    name = "${pname}-${version}.dmg";
    url = "https://cachefly.alfredapp.com/Alfred_${version}.dmg";
    sha256 = "${sha256}";
  };
}
