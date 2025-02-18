# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Enable font.fontDir
  fonts.fontDir.enable = true;

  # Running X11 applications or any other program uses Fontconfig.
  # A config file pointing to a set of default fonts
  #fonts.fontconfig.enable = true;

  # Enables bitmap support
  fonts.fontconfig.useEmbeddedBitmaps = true;

  # Some "basic" fonts to be installed for reasonable Unicode coverage
  # Enable if you are unsure about what languages you might end up reading
  fonts.enableDefaultPackages = true;


  fonts.packages = with pkgs; [
	hack-font
	nerd-fonts.fira-code
	nerd-fonts.jetbrains-mono
	nerd-fonts.zed-mono
	nerd-fonts.victor-mono
	nerd-fonts.iosevka
	nerd-fonts.iosevka-term
	udev-gothic-nf			# Programming font with UD Gothic, JBrains and NF
	ipaexfont 		    	# JP font with Mincho and Gothic fonts
	noto-fonts-cjk-sans	  # Sans style between modern and traditional Chinese,Japanese,Korean fonts
  noto-fonts-cjk-serif		# Serif style between modern and traditional Chinese,Japanese,Korean fonts
  kanji-stroke-order-font		# Contains diagrams for 6500+ kanjis and more
  #(callPackage ./siyamrupali/default.nix { inherit pkgs; })            # Siyam Rupali Bangla Font(have issues rn)

  ];

}
