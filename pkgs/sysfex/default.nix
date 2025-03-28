{ stdenv, pkgs , fetchFromGitHub, cmake, viu, icu }:

stdenv.mkDerivation rec {
  pname = "sysfex";
  version = "0.1.0"; # Replace with the actual version

  src = fetchFromGitHub {
    owner = "ChrolloRifat";
    repo = "sysfex";
    rev = "f22b99467884d9dcb1acfe527c1940f1833ab23e"; # Replace with the actual tag or commit hash
    sha256 = "00bj6gqgwviigfwzksq7h7sz0nyrwvd0ycl3m2iijbv9pacqxicb"; # Replace with the actual SHA256 hash
  };

  buildInputs = [ cmake viu icu ];

  nativeBuildInputs = [
   pkgs.cmake
  ];

  buildPhase = ''
    mkdir build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release
    cmake --build .
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp build/sysfex $out/bin/
  '';

  meta = with pkgs.lib; {
    description = "Just another system information fetching tool written in C++ ";
    homepage = "https://github.com/mehedirm6244/sysfex";
    license = licenses.gpl3; 
    maintainers = with maintainers; [ ChrolloRifat ];
    platforms = platforms.all;
  };
}
