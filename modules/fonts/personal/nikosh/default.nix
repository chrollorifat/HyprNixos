{ lib, stdenv, fontconfig, pkgs, ...}:

stdenv.mkDerivation rec {
  pname = "Nikosh";
  version = "1.00";

  src = ./ttf/.;

  buildInputs = [ fontconfig ];
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p "$out/share/fonts"
    cp -r ${src} "$out/share/fonts/"
  '';

  meta = with lib; {
    description = "Nikosh font developed by election commision of Bangladesh";
    license = licenses.ofl;
    maintainers = [ maintainers.ChrolloRifat ];
    platforms = platforms.all;
  };
}
