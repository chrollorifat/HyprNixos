{ lib, stdenv, fontconfig, pkgs, ...}:

stdenv.mkDerivation rec {
  pname = "Bangladesh-Protidin";
  version = "1.1";

  src = ./BDPRATID.TTF;

  buildInputs = [ fontconfig ];
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p "$out/share/fonts"
    cp ${src} "$out/share/fonts/"
  '';

  meta = with lib; {
    description = "Bangla Font used in the newspaper print Bangladesh Protidin";
    license = licenses.ofl;
    maintainers = [ maintainers.ChrolloRifat ];
    platforms = platforms.all;
  };
}
