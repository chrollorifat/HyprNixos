{ config, pkgs, inputs, ndots, ... }:

{
  # imports = [./personal/default.nix];  # doesn't exactlty work as intended (WIP)

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
        "JetBrainsMono Nerd Font"
        "Migu"
        "DejaVu Sans Mono"
        "FiraCode Nerd Font Mono"
        "Maple Mono Nerd Font"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Lexend"
        "Migu"
        "Jost"
        "DejaVu Sans"
        "SFProDisplay Nerd Font"
        "Noto Sans CJK JP"
        "Noto Color Emoji"
      ];
      serif = [
        "Lora"
        "Merriweather"
        "MigMix"
        "DejaVu Serif"
        "SFProDisplay Nerd Font"
        "Noto Serif CJK JP"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };

  fonts.packages = with pkgs; [
    hack-font
    dejavu_fonts
    noto-fonts
    noto-fonts-emoji
    lexend
    lato
    lora
    jost
    comic-neue
    comfortaa
    merriweather

    # Icon Fonts
    material-icons
    openmoji-color
    twemoji-color-font
    material-design-icons # 7k+ material design icons from the community
    font-awesome
    font-awesome_5
    (callPackage ./font-awesome {})

    # Nerd Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.zed-mono
    nerd-fonts.victor-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    maple-mono-NF
    udev-gothic-nf	# Programming font with UD Gothic, JBrains and NF
    (callPackage ./personal/caskaydia-cove {})

    # Japanese Fonts
    ipaexfont  # JP font with Mincho and Gothic fonts
    noto-fonts-cjk-sans	# Sans style between modern and traditional Chinese,Japanese,Korean fonts
    noto-fonts-cjk-serif # Serif style between modern and traditional Chinese,Japanese,Korean fonts
    kanji-stroke-order-font	 # Contains diagrams for 6500+ kanjis and more
    migmix  # High Quality JP font based on M+ and IPA fonts
    hachimarupop  # Cute Japanese Font
    migu  # HQ JP font based on modified M+ and IPA fonts
    hanazono  # JP Mincho Typeface Truetype font
    kochi-substitute  # Free replacement for MS Gothic and MS Mincho JP

    # Personal Custom Fonts
    (callPackage ./personal/kalpurush {})  # Kalpurush Bangla Font
    (callPackage ./personal/beyond-wonderland {})  # Beyond Wonderland Font
    (callPackage ./personal/sutonnymj {})  # SutonnyMj Bangla Font
    (callPackage ./personal/siyamrupali {})  # Siyam Rupali Bangla Font
    (callPackage ./personal/bangla {})  
    (callPackage ./personal/shonar-bangla {})  # Microsoft's Shonar Bangla Font
    (callPackage ./personal/apona-lohit {})  # AponaLohit Bangla Font
    (callPackage ./personal/bd-protidin {})  # BDProtidin newspaper Bangla Font
    (callPackage ./personal/bengali-dhaka-ssk {})
    (callPackage ./personal/himu {})  # Himu Bangla Font
    (callPackage ./personal/nikosh {})  # Nikosh Bangla Font
    (callPackage ./personal/shurjo {})  # Shurjo Bangla Font
    (callPackage ./proxima-nova {})
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
