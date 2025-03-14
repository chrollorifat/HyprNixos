{ lib, stdenv, fontconfig, pkgs, ...}:

stdenv.mkDerivation rec {
  pname = "beyond-wonderland";
  version = "Unknown";

  src = ./Beyond-Wonderland.ttf;

  buildInputs = [ fontconfig ];
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p "$out/share/fonts"
    cp ${src} "$out/share/fonts/"
  '';

  meta = with lib; {
    description = "Beyond Wonderful Font";
    license = licenses.ofl;
    maintainers = [ maintainers.ChrolloRifat];
    platforms = platforms.all;
  };
}
