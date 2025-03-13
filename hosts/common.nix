{
  inputs,
  pkgs,
  overlays,
  username,
  browser,
  terminal,
  sddmTheme,
  locale,
  timezone,
  kbdLayout,
  kbdVariant,
  consoleKeymap,
  config,
  self,
  ...
}: let
  scripts = pkgs.callPackage ../modules/scripts {};
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
  ];

  programs.nix-index-database.comma.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
      "input"
      "disk"
      "libvirtd"
      "video"
      "audio"
      "storage"
    ];
  };

  # Common home-manager options that are shared between all systems.
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.${username} = {pkgs, ...}: {
      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;

      xdg.enable = true;
      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.11"; # Please read the comment before changing.
      home.sessionVariables = {
        EDITOR = "nvim";
        BROWSER = "ungoogled-chromium";
        TERMINAL = terminal;
      };

      # Packages that don't require configuration. If you're looking to configure a program see the /modules dir
      home.packages = with pkgs; [
        # Applications
        #kate

        # Terminal
        fzf
        fd
        git
        gh
        github-desktop
        htop
        nix-prefetch-scripts
        neofetch
        microfetch
        ripgrep
        tldr
        unzip
        (pkgs.writeShellScriptBin "hello" ''
          echo "Hello ${username}!"
        '')
      ];
    };
  };

  # Filesystems support
  boot.supportedFilesystems = ["ntfs" "exfat" "ext4" "fat32" "btrfs"];
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Bootloader.
  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_zen; # _latest, _zen, _xanmod_latest, _hardened, _rt, _OTHER_CHANNEL, etc.
    #kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
    # extraModulePackages = with config.boot.kernelPackages; [
          # rtl88xxau-aircrack # Driver to ensure Wi-Fi adapters work
    # ];
    loader = {
      #efi.canTouchEfiVariables = true;
      #efi.efiSysMountPoint = "/boot";
      timeout = 5; # Display bootloader indefinitely until user selects OS
      grub = {
        enable = true;
        device = "/dev/sda";
        #efiSupport = true;
        useOSProber = true;
        gfxmodeEfi = "2715x1527"; # for 4k: 3840x2160
        gfxmodeBios = "2715x1527"; # for 4k: 3840x2160
        theme = pkgs.stdenv.mkDerivation {
          pname = "distro-grub-themes";
          version = "3.1";
          src = pkgs.fetchFromGitHub {
            owner = "AdisonCavani";
            repo = "distro-grub-themes";
            rev = "v3.1";
            hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
          };
          installPhase = "cp -r customize/nixos $out";
        };
      };
    };
  };

  # Timezone and locale
  time.timeZone = timezone;
  i18n.defaultLocale = locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = locale;
    LC_IDENTIFICATION = locale;
    LC_MEASUREMENT = locale;
    LC_MONETARY = locale;
    LC_NAME = locale;
    LC_NUMERIC = locale;
    LC_PAPER = locale;
    LC_TELEPHONE = locale;
    LC_TIME = locale;
  };
  # Japanese Locale support
  i18n.supportedLocales = [
    "all"
  ];

  console.keyMap = consoleKeymap; # Configure console keymap
  services.xserver = {
    exportConfiguration = true; # Make sure /etc/X11/xkb is populated so localectl works correctly
    xkb = {
      layout = kbdLayout;
      variant = kbdVariant;
    };
  };

  security = {
    polkit.enable = true;
    #sudo.wheelNeedsPassword = false;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };

  # Enable dconf for home-manager
  programs.dconf.enable = true;

  # Enable bluetooth
  services.blueman.enable = true;
  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.Experimental = true;
  };

  # Enable networking
  networking = {
    # hostName = hostname; # Define your hostname.
    networkmanager.enable = true;
    # wireless.enable = true; # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Enable sddm login manager
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      settings.Theme.CursorTheme = "Bibata-Modern-Classic";
    };
  };

  # Setup  keyring
  services.gnome.gnome-keyring.enable = true;
  /* # Setup Auth Agent (No need if hyprpolkitagent is activated)
  systemd = {
    user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  */
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.xserver.enable = true; # Enable the X11 windowing system.

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  nixpkgs = {
    config.allowUnfree = true;
    # config.allowUnfreePredicate = _: true;
    inherit overlays;
  };

  environment.sessionVariables = {
    # These are the defaults, and xdg.enable does set them, but due to load
    # order, they're not set before environment.variables are set, which could
    # cause race conditions.
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_BIN_HOME = "$HOME/.local/bin";

    templates = "${self}/dev-shells";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Scripts
    scripts.tmux-sessionizer
    scripts.collect-garbage
    scripts.driverinfo
    #scripts.underwatt

    # System
    killall
    lm_sensors
    jq
    bibata-cursors
    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.qtmultimedia
    pkgs.kdePackages.qtvirtualkeyboard
    #vulkan-tools
    (pkgs.callPackage ../pkgs/sddm-themes/astronaut.nix {
          theme = sddmTheme;
    })
    # libsForQt5.qt5.qtgraphicaleffects # For sddm to function properly

    # Development
    #devbox # faster nix-shells
    #shellify # faster nix-shells
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.

     services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        # AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 3d --keep 3";
      };
      flake = "/home/${username}/chrono-nixos-config";
    };
  };

  nix = {
    # Nix Package Manager Settings
    settings = {
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org/"
        "https://chaotic-nyx.cachix.org/"
        "https://cachix.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-gaming.cachix.org/"
        "https://devenv.cachix.org"

      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
         "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
      experimental-features = ["nix-command" "flakes"];
      use-xdg-base-directories = false;
      warn-dirty = false;
      keep-outputs = true;
      keep-derivations = true;
      };

  # Garbage Collection
  #gc = {
      #    automatic = true;
      #dates = "daily";
      #options = "--delete-older-than 6d";
    #};
    optimise.automatic = true;
    package = pkgs.nixVersions.stable;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
