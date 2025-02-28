{ stdenv, lib }:

stdenv.mkDerivation {
  name = "siyamrupali";
  src = ./Siyamrupali.ttf;

  phases = ["installPhase"];

  installPhase = ''
    install -D $src $out/share/fonts/truetype/Siyamrupali.ttf
  '';
}
