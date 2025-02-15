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
        google-chrome
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
    kitty
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
    starship
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
    en-croissant


    alacritty
    ghostty
    anki-bin
    discord
    sublime4
    telegram-desktop
    qbittorrent-enhanced
    zed-editor
    ungoogled-chromium

    # using the flake of zen browser
      #flk-zen-browser

    # SDDM
    #sddm-astronaut

    # Anime & Manga Stuff
    #miru

    zen-browser

  ];

}
