{ config, pkgs, inputs, ndots, ... }:

{
  #siyamrupali = pkgs.callPackage ./siyamrupali { };
  #kalpurush = pkgs.callPackage ./kalpurush {inherit pkgs; };

  # Enable font.fontDir
  fonts.fontDir.enable = true;

  # Running X11 applications or any other program uses Fontconfig.
  # A config file pointing to a set of default fonts
  fonts.fontconfig.enable = true;

  # Enables bitmap support
  fonts.fontconfig.useEmbeddedBitmaps = true;

  # Some "basic" fonts to be installed for reasonable Unicode coverage
  # Enable if you are unsure about what languages you might end up reading
  fonts.enableDefaultPackages = true;
  fonts.fontconfig.defaultFonts = {
      monospace = [
        "DejaVu Sans Mono"
        "IPAGothic"
      ];
      sansSerif = [
        "DejaVu Sans"
        "IPAPGothic"
      ];
      serif = [
        "DejaVu Serif"
        "IPAPMincho"
      ];
    };

  fonts.packages = with pkgs; [
	hack-font
	nerd-fonts.fira-code
	nerd-fonts.jetbrains-mono
	nerd-fonts.zed-mono
	nerd-fonts.victor-mono
	nerd-fonts.iosevka
	nerd-fonts.iosevka-term
	udev-gothic-nf	# Programming font with UD Gothic, JBrains and NF
	ipaexfont  # JP font with Mincho and Gothic fonts
	noto-fonts-cjk-sans	# Sans style between modern and traditional Chinese,Japanese,Korean fonts
  noto-fonts-cjk-serif # Serif style between modern and traditional Chinese,Japanese,Korean fonts
  kanji-stroke-order-font	 # Contains diagrams for 6500+ kanjis and more
  material-design-icons # 7k+ material design icons from the community
  font-awesome_5
  migmix  # High Quality JP font based on M+ and IPA fonts
  hachimarupop  # Cute Japanese Font
  #(callPackage ./siyamrupali/default.nix { inherit pkgs; })  # Siyam Rupali Bangla Font(have issues rn)
  #siyamrupali
  inputs.ndots.packages."x86_64-linux".road-rage

  ];

  # Ensure the Fontconfig cache is updated after the fonts are installed
  systemd.services.update-font-cache = {
    description = "Update Fontconfig cache";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.fontconfig}/bin/fc-cache -f -v";
    };
    wantedBy = [ "multi-user.target" ];
  };

}
