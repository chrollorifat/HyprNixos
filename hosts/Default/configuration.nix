{
  pkgs,
  gpuDriver,
  hostname,
  ...
}: {
  imports = [
    ../common.nix
    ../../modules/desktop/hyprland # Enable hyprland window manager

    ../../modules/hardware/video/${gpuDriver}.nix # Enable gpu drivers defined in flake.nix

    ../../modules/fonts

    #../../modules/programs/games
    ../../modules/programs/media/discord
    #../../modules/programs/media/spicetify
    #../../modules/programs/media/obs
    ../../modules/programs/media/thunderbird

    # ../../modules/hardware/drives
    ./hardware-configuration.nix
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
        kdePackages.okular # pdf viwer
        evince  
        # godot_4
        # unityhub
        # gparted
      ];
    })
  ];
  environment.systemPackages = with pkgs; [
    ### Archiving Utilities
    p7zip-rar
    p7zip
    gnutar
    zip
    unrar-free
    kdePackages.ark
  ];
  # Archive manager
  programs.file-roller = {
    enable = true;
    package = pkgs.file-roller;
  };

  networking.hostName = hostname; # Define your hostname.
  

  # Stream my Language lessons to my devices via vlc media player
  /*services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      friendly_name = "NixOS-DLNA";
      media_dir = [ # A = Audio, P = Pictures, V, = Videos, PV = Pictures and Videos.
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
