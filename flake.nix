{
  description = "A simple flake for an atomic system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:Sly-Harvey/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    thunderbird-catppuccin = {
      url = "github:catppuccin/thunderbird";
      flake = false;
    };
    zen-browser = {
      url = "github:maximoffua/zen-browser.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvchad4nix = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nvchad-on-steroids = {
      # <- here
      # url = "github:maotseantonio/nvchad_config";
      # flake = false;
    # };
    # hyprpanel= {
      # url = "github:Jas-SinghFSU/HyprPanel";
      # inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nixpkgs-f2k = {
      # url = "github:moni-dz/nixpkgs-f2k";
      # inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    ...
  } @ inputs: let
    inherit (self) outputs;
    settings = {
      # User configuration
      username = "rif"; # automatically set with install.sh and rebuild.sh via the logname command
      editor = "nvchad"; # nixvim, vscode, emacs, nvchad, neovim
      terminal = "wezterm"; # kitty or alacritty
      browser = "floorp"; # firefox, floorp, zen
      terminalFileManager = "yazi"; # yazi or lf
      sddmTheme = "purple_leaves"; # astronaut, black_hole, purple_leaves, jake_the_dog, hyprland_kath
      wallpaper = "dark-forest.jpg"; # see modules/themes/wallpapers

      # System configuration
      gpuDriver = "intel"; # CHOOSE YOUR GPU DRIVERS (nvidia or amdgpu or intel) THIS IS IMPORTANT
      hostname = "HyprNixos"; # CHOOSE A HOSTNAME HERE
      locale = "en_GB.UTF-8"; # CHOOSE YOUR LOCALE
      timezone = "Asia/Dhaka"; # CHOOSE YOUR TIMEZONE
      kbdLayout = "us"; # CHOOSE YOUR KEYBOARD LAYOUT
      kbdVariant = ""; # CHOOSE YOUR KEYBOARD VARIANT (Can leave empty)
      consoleKeymap = "us-acentos"; # CHOOSE YOUR CONSOLE KEYMAP (Affects the tty?)
    };

    systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        forAllSystems = nixpkgs.lib.genAttrs systems;
      in {
        templates = import ./dev-shells;
        overlays = import ./overlays {inherit inputs settings;};
        formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
        nixosConfigurations = {
          Default = nixpkgs.lib.nixosSystem {
            system = forAllSystems (system: system);
            specialArgs = {inherit self inputs outputs;} // settings;
            modules = [./hosts/Default/configuration.nix];

      };
    };
    devShells = forAllSystems (system: let
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
            config.nvidia.acceptLicense = true;
            # overlays = settings.overlays;
          };
        in {
          default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              git
              neovim
              nix
              figlet
              lolcat
            ];
            NIX_CONFIG = "experimental-features = nix-command flakes";
          };
        });
      };
}
