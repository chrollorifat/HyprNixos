{
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "siyamrupali";
  version = "1.065";
  src = ./.;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    if [ -d "$src/fonts" ]; then
      cp -r $src/fonts/*.ttf $out/share/fonts/truetype/
    else
      echo "No fonts found in $src/fonts"
      exit 0
    fi
  '';

  meta = with lib; {
    description = "Siyam Rupali Bangla font Regular";
    homepage = "https://www.freebanglafont.com/download.php?id=724";
    platforms = platforms.all;
  };
}

