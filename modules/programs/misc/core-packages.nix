# Edit this configuration file to define what should be installed on
# your system.

{ config, inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # wpsoffice
    arandr
    # arc-theme
    avahi
    baobab
    # bibata-cursors
    blueberry
    btop
    curl
    dex
    dmenu
    duf
    edid-decode
    feh
    # filezilla
    flameshot
    font-manager
    fsearch
    # gimp
    # git
    dconf-editor
    gnome-disk-utility
    # gnome.gvfs   # Enabled through NixOS options
    # hblock
    hw-probe
    hwinfo
    # i3lock-fancy
    # inkscape
    # insync
    # inxi
    keepassxc
    # killall
    libgccjit
    llvmPackages_17.libcxxClang
    # lm_sensors  # Already declared in common.nix
    # lollypop
    lshw
    meld
    most
    # neovim
    # fastfetch  # Enabled through modules
    networkmanagerapplet
    nixos-generators

    ###----- Image -----###
    nomacs
    imv
    # variety   # Wallpaper selector

    ###----- Video -----###
    # vlc
    # mpv  # Enabled through module

    ###----- Screen Recording -----###
    # obs-studio
    # simplescreenrecorder  # Only works with x11, no wayland support atm

    numlockx
    volumeicon
    brightnessctl
    platinum-searcher
    # ripgrep
    # polybar
    qt6Packages.qtstyleplugin-kvantum
    scrot
    # spotify
    # ookla-speedtest
    wget
    xorg.xkill

    ###----- Chess Toolkits -----###
    # en-croissant

    
    ###----- Terminal -----###   
    # alacritty  # Enabled through the modules
    # ghostty    
    # kitty    # Enabled through the modules
    # starship
    # wezterm  # Enabled through the modules
    bash-completion
    bat  
    tree
    # zsh
    # zsh-autosuggestions
    # zsh-completions
    # zsh-syntax-highlighting


    anki-bin
    # discord
    telegram-desktop
    qbittorrent-enhanced

    ###----- Editors -----###  
    zed-editor
    sublime4
    # vscode

    ###----- Browsers -----###
    google-chrome
    ungoogled-chromium
    widevine-cdm
    # firefox-devedition
    # vivaldi
    # vivaldi-ffmpeg-codecs

    
    nwg-look
    waytrogen # Fast wallpaper setter for wayland

    ###----- Anime & Manga Stuff -----###
    # miru
    # yacreader

    # Find username across all social netwrks
    sherlock

    evince
    pdfarranger  # pdf merging and splitting tool

    # etcher
    ventoy-full  # usb flasher

    yt-dlp   # cli tool for downloading youtube videos

  ];

}
