{ pkgs, ... }:

let
  # Remember to update the hash when the version changes
  # nix flake prefetch --extra-experimental-features 'nix-command flakes' --json github:Diomeh/nix-xdm/<VERSION>
  xdm = pkgs.fetchFromGitHub {
    owner = "Diomeh";
    repo = "nix-xdm";
    rev = "0.0.1";
    hash = "sha256-uME0V2thw0ANiqAgFHnSlPWG7Lg3iR1QLkcsFdQ0bT8=";
  };
in
{
  environment.systemPackages = [
    (pkgs.callPackage "${xdm}/derivation.nix" { inherit pkgs; })
  ];
}
