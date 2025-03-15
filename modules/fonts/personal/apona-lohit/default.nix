{ lib, stdenv, fontconfig, pkgs, ...}:

stdenv.mkDerivation rec {
  pname = "Apona-Lohit";
  version = "1.01";

  src = ./AponaLohit.ttf;

  buildInputs = [ fontconfig ];
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p "$out/share/fonts"
    cp ${src} "$out/share/fonts/"
  '';

  meta = with lib; {
    description = "AponaLohit Bangla Font";
    license = licenses.ofl;
    maintainers = [ maintainers.ChrolloRifat ];
    platforms = platforms.all;
  };
}
