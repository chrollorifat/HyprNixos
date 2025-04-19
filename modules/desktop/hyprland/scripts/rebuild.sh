#!/usr/bin/env bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be executed as root! Exiting..."
  exit 1
fi

if [[ ! "$(grep -i nixos </etc/os-release)" ]]; then
  echo "This installation script only works on NixOS! Download an iso at https://nixos.org/download/"
  echo "Keep in mind that this script is not intended for use while in the live environment."
  exit 1
fi


if [ -f "$HOME/NixOS/flake.nix" ]; then
  flake=$HOME/HyprNixos
elif [ -f "/etc/nixos/flake.nix" ]; then
  flake=/etc/nixos
else
  echo "Error: flake not found. ensure flake.nix exists in either $HOME/HyprNixos or /etc/nixos"
  exit 1
fi

currentUser=$(logname)

pushd "$HOME/HyprNixos" &>/dev/null || exit 0

# replace username variable in flake.nix with $USER
sudo sed -i -e "s/username = \".*\"/username = \"$currentUser\"/" "$flake/flake.nix"

if [ ! -f "$scriptdir/hosts/Default/hardware-configuration.nix" ]; then
  if [ -f "/etc/nixos/hardware-configuration.nix" ]; then
    for host in "$scriptdir"/hosts/*/; do
      host=${host%*/}
      cat "/etc/nixos/hardware-configuration.nix" >"$host/hardware-configuration.nix"
    done
    elif [ -f "/etc/nixos/hosts/Default/hardware-configuration.nix" ]; then
      for host in "$scriptdir"/hosts/*/; do
        host=${host%*/}
        cat "/etc/nixos/hosts/Default/hardware-configuration.nix" >"$host/hardware-configuration.nix"
      done
  else
    # Generate new config
    clear
    nix develop "$scriptdir" --command bash -c "echo GENERATING CONFIG! | figlet -cklno | lolcat -F 0.3 -p 2.5 -S 300"
    for host in "$scriptdir"/hosts/*/; do
      host=${host%*/}
      sudo nixos-generate-config --show-hardware-config >"$host/hardware-configuration.nix"
    done
  fi
fi
git -C "$scriptdir" add hosts/Default/hardware-configuration.nix

# nh os switch "$scriptdir" --hostname Default
sudo nixos-rebuild switch --flake "$scriptdir#Default"
rm ~/HyprNixos/hosts/Default/hardware-configuration.nix &>/dev/null
git restore --staged ~/HyprNixos/hosts/Default/hardware-configuration.nix &>/dev/null

echo
read -rsn1 -p"$(echo -e "${GREEN}Press any key to continue${NC}")"

popd "$HOME/HyprNixos" &>/dev/null || exit 0
