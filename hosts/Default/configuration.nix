{
  pkgs,
  videoDriver,
  hostname,
  browser,
  editor,
  terminal,
  terminalFileManager,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/video/${videoDriver}.nix # Enable gpu drivers defined in flake.nix
    ../../modules/fonts
    # ../../modules/hardware/drives

    ../common.nix
    ../../modules/scripts

    ../../modules/desktop/hyprland # Enable hyprland window manager
    # ../../modules/desktop/i3-gaps # Enable i3 window manager 

    ../../modules/programs/games
    ../../modules/programs/browser/${browser} # Set browser defined in flake.nix
    ../../modules/programs/terminal/${terminal} # Set terminal defined in flake.nix
    ../../modules/programs/terminal/kitty  # Enable kitty terminal
    ../../modules/programs/editor/${editor} # Set editor defined in flake.nix
    ../../modules/programs/cli/${terminalFileManager} # Set file-manager defined in flake.nix
    ../../modules/programs/cli/starship
    ../../modules/programs/cli/tmux
    ../../modules/programs/cli/direnv
    ../../modules/programs/cli/lazygit
    ../../modules/programs/cli/cava
    ../../modules/programs/cli/btop
    ../../modules/programs/shell/bash
    ../../modules/programs/shell/zsh
    ../../modules/programs/media/discord
    ../../modules/programs/media/spicetify
    # ../../modules/programs/media/youtube-music
    # ../../modules/programs/media/thunderbird
    ../../modules/programs/media/obs-studio
    ../../modules/programs/media/mpv
    ../../modules/programs/misc/tlp
    ../../modules/programs/misc/thunar
    # ../../modules/programs/misc/nix-ld
    # ../../modules/programs/misc/virt-manager
    # ../../modules/programs/misc/lact # gpu power and fan control (WIP)
    ../../modules/programs/misc/fcitx
  ];

  # Home-manager config
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        # pokego # Overlayed
        # lact # Overlayed [LONG COMPILE]

        ###---Terminal---###
        pokego  # Overlayed
        bash-completion
        sherlock  # Find username across all social netwrks 
        yt-dlp  # Cli tool for downloading youtube videos

        ###---Image---###
        gimp
        imv
        krita
        nomacs
        waytrogen # Fast wallpaper setter for wayland

        # lact # Overlayed [LONG COMPILE]
        anki-bin
        github-desktop
        nwg-look
        zed-editor

        ###---Documents---###
        evince
        kdePackages.okular # pdf viewer
        koodo-reader # Ebook reader (cross platform)
        meld
        obsidian  # Markdown Note Taking app
        pdfarranger  # pdf merging and splitting tool
        readest  # Ebook reader
        yacreader  # comic viewer

        keepassxc
        # godot_4
        # unityhub
        # gparted
      ];
    })
  ];

  # Define system packages here
  environment.systemPackages = with pkgs; [
    # Archiving Utilities
    p7zip-rar
    p7zip
    gnutar
    zip
    unrar-free
    unzip
    kdePackages.ark

    ###----- Browsers -----###
    # google-chrome
    brave
    ungoogled-chromium
    widevine-cdm
    # firefox-devedition
    # vivaldi
    # vivaldi-ffmpeg-codecs

    dconf-editor
    dex
    font-manager
    fsearch
    gnome-disk-utility
    # libgccjit
    # llvmPackages_17.libcxxClang
    nixos-generators
    platinum-searcher
    scrot
    ventoy-full  # usb flasher
  ];

  networking.hostName = hostname; # Set hostname defined in flake.nix

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    "ventoy-1.1.05"
  ];

}
