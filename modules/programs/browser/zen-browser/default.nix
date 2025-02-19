# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# https://releases.nixos.org/nixos/unstable/

{ config, pkgs, inputs, zen-browser, ... }:
{
      environment.systemPackages = with pkgs; [
        inputs.zen-browser.packages."x86_64-linux".default
      ];
}
