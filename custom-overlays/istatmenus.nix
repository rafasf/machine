{ stdenv, fetchurl, undmg, unzip }:

let
  pname = "iStatMenus";
  version = "6.60";
  sha256 = "253deb678827b5be38a072c4470917ee271ef63edbb4427e6c88c9adcfd4dcf9";
in
stdenv.mkDerivation {
  inherit pname version sha256;

  name = "${pname}-${version}";
  buildInputs = [ unzip ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "iStat Menus.app" "$out/Applications/iStat Menus.app"
    '';

  src = fetchurl {
    name = "istatmenus${version}.zip";
    url = "https://cdn.bjango.com/files/istatmenus6/istatmenus${version}.zip";
    sha256 = "${sha256}";
  };
}
