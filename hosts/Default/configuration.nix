{
  pkgs,
  gpuDriver,
  hostname,
  browser,
  editor,
  terminal,
  terminalFileManager,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/video/${gpuDriver}.nix # Enable gpu drivers defined in flake.nix
    ../../modules/hardware/drives
    ../common.nix
    ../../modules/fonts

    ../../modules/desktop/hyprland # Enable hyprland window manager

    #../../modules/programs/games

    # ../../modules/programs/terminal/${terminal} # Set terminal defined in flake.nix
    # ../../modules/programs/terminal/alacritty
    ../../modules/programs/terminal/kitty
    ../../modules/programs/terminal/wezterm

    ../../modules/programs/browser/${browser} # Set browser defined in flake.nix
    ../../modules/programs/browser/zen
    ../../modules/programs/editor/${editor} # Set editor defined in flake.nix
    # ../../modules/programs/editor/nvchad
    # ../../modules/programs/editor/vscode

    ../../modules/programs/shell/bash
    ../../modules/programs/shell/zsh

    ../../modules/programs/cli/starship
    ../../modules/programs/cli/fastfetch
    ../../modules/programs/cli/tmux
    ../../modules/programs/cli/direnv
    ../../modules/programs/cli/${terminalFileManager} # Set file-manager defined in flake.nix
    ../../modules/programs/cli/lazygit
    ../../modules/programs/cli/cava
    ../../modules/programs/cli/btop

    #../../modules/programs/media/obs
    #../../modules/programs/media/spicetify
    ../../modules/programs/media/discord
    ../../modules/programs/media/thunderbird
    ../../modules/programs/media/mpv

    # ../../modules/programs/misc/lact # gpu power and fan control (WIP)
    # ../../modules/programs/misc/nix-ld
    # ../../modules/programs/misc/virt-manager
    # ../../modules/programs/misc/env-vars.nix
    ../../modules/programs/misc/core-packages.nix
    ../../modules/programs/misc/fcitx
    ../../modules/programs/misc/kdeconnect.nix
    ../../modules/programs/misc/thunar
    ../../modules/programs/misc/tlp
  ];

  # UnComment this section only if you have chosen intel as your gpu in flake.nix
  hardware.intel = {
    enable = true;
    enableThermal = true;
    enableMediaAccel = true;
  };


  # Home-manager config
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        #krita
        #gimp
        (pkgs.callPackage ../../pkgs/pokego.nix {})
        kdePackages.okular # pdf viwer
        evince
        # godot_4
        # unityhub
        # gparted
      ];
    })
  ];

  # Define system packages here
  environment.systemPackages = with pkgs; [
    ### Archiving Utilities
    p7zip-rar
    p7zip
    gnutar
    zip
    unrar-free
    kdePackages.ark
  ];

  networking.hostName = hostname; # Set hostname defined in flake.nix

  # Stream my Language lessons to my devices via vlc media player
  /*services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      friendly_name = "NixOS-DLNA";
      media_dir = [
        # A = Audio, P = Pictures, V, = Videos, PV = Pictures and Videos.
        "/mnt/work/Pimsleur"
        # "A,/mnt/work/Pimsleur/Russian"
      ];
      inotify = "yes";
      log_level = "error";
    };
  };
  users.users.minidlna = {
   extraGroups = ["users"]; # so minidlna can access the files.
  };
  */
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
    # "electron-19.1.9"
  ];


}
