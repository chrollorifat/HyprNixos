{ lib, stdenv, fontconfig, pkgs, ...}:

stdenv.mkDerivation rec {
  pname = "BengaliDhakaSSK";
  version = "4.1";

  src = ./ttf/.;

  buildInputs = [ fontconfig ];
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p "$out/share/fonts"
    cp -r ${src} "$out/share/fonts/"
  '';

  meta = with lib; {
    description = "BengaliDhakaSSK Font created by Macromedia Fontographer";
    license = licenses.ofl;
    maintainers = [ maintainers.ChrolloRifat ];
    platforms = platforms.all;
  };
}
