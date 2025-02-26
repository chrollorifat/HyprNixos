{ lib, stdenv, fontconfig, pkgs, ...}:

stdenv.mkDerivation rec {
  pname = "kalpurush";
  version = "6.2";

  src = ./kalpurush.ttf;

  buildInputs = [ fontconfig ];
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p "$out/share/fonts"
    cp ${src} "$out/share/fonts/"
  '';

  meta = with lib; {
    description = "Punky Style font";
    license = licenses.ofl;
    maintainers = [ maintainers.niksingh710 ];
    platforms = platforms.all;
  };
}
