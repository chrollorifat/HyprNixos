# Edit this configuration file to define what should be installed on
# your system.

{ config, pkgs, ... }:
# Flake for installing the Zen Browser
#let
#  flk-zen-browser = (builtins.getFlake "github:youwen5/zen-browser-flake").packages.x86_64-linux.default;
#in

{
  environment.systemPackages =
      with pkgs; [
        #ckb-next
        #wpsoffice
        arandr
       #arc-theme
        avahi
        baobab
        bash-completion
        bat
        bibata-cursors
        blueberry
        btop
        curl
        dex
    dmenu
    #dropbox
    duf
    edid-decode
    #etcher
    evince
    feh
    #filezilla
    firefox-devedition
    flameshot
    font-manager
    fsearch
    #gimp
    git
    dconf-editor
    gnome-disk-utility
    gnome.gvfs
    hblock
    hw-probe
    hwinfo
    #i3lock-fancy
    #inkscape
    #insync
    #inxi
    keepassxc
    killall
    libgccjit
    llvmPackages_17.libcxxClang
    lm_sensors
    #lollypop
    lshw
    meld
    most
    neovim
    neofetch
    fastfetch
    networkmanagerapplet
    nixos-generators
    nomacs
    numlockx
    #obs-studio
    #ookla-speedtest
    platinum-searcher
    #polybar
    qt6Packages.qtstyleplugin-kvantum
    ripgrep
    scrot
    #simplescreenrecorder
    #spotify
    tree
    variety
    #vivaldi
    #vivaldi-ffmpeg-codecs
    #vlc
    mpv
    volumeicon
    #vscode
    wget
    widevine-cdm
    xorg.xkill
    zsh
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting

    # Chess Toolkits
    #en-croissant

    
    # Terminals  
    alacritty
    ghostty
    kitty
    starship


    anki-bin
    discord
    telegram-desktop
    qbittorrent-enhanced

    # Editors  
    zed-editor
    sublime4


    google-chrome
    ungoogled-chromium

    
    brightnessctl
    # using the flake of zen browser
      #flk-zen-browser

    # SDDM
    #sddm-astronaut

    # Anime & Manga Stuff
    #miru

  ];

}
