# make a  derivation for siyamrupali font installation
{ pkgs }:
pkgs.stdenv.mkDerivation {
  pname = "siyamrupali";
  version = "1.009";

  src = ../siyamrupali.zip;

  unpackPhase = ''
    runHook preUnpack
    ${pkgs.unzip}/bin/unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 siyamrupali/*.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}
