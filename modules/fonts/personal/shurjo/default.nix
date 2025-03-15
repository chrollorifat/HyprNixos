{ lib, stdenv, fontconfig, pkgs, ...}:

stdenv.mkDerivation rec {
  pname = "Shujo";
  version = "Unknown";

  src = ./ttf/.;

  buildInputs = [ fontconfig ];
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p "$out/share/fonts"
    cp -r ${src} "$out/share/fonts/"
  '';

  meta = with lib; {
    description = "Shurjo Bangla Font";
    license = licenses.ofl;
    maintainers = [ maintainers.ChrolloRifat ];
    platforms = platforms.all;
  };
}
