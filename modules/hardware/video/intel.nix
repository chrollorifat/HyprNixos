{ lib, pkgs, config, ... }:

with lib;

let
  cfg = config.hardware.intel; # Changed from drivers.intel to standard namespace
in {
  options.hardware.intel = {
    enable = mkEnableOption "Intel hardware configuration";
    
    enableThermal = mkEnableOption "thermal management" // { default = true; };
    enableMediaAccel = mkEnableOption "media acceleration" // { default = true; };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      # Graphics Configuration
      services.xserver.videoDrivers = [ "modesetting" ];
      hardware.opengl = {
        enable = true;
        driSupport = true;
        extraPackages = with pkgs; [
          intel-media-driver
          vaapiIntel
          libvdpau-va-gl
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          vaapiIntel
          libvdpau-va-gl
        ];
      };

      # Power Management
      powerManagement = {
        enable = true;
        cpuFreqGovernor = "powersave";
        powertop.enable = true;
      };

      boot.kernelParams = [
        "i915.enable_guc=2"       # Enable GuC/HuC firmware loading
        "i915.enable_psr=1"       # Panel Self Refresh
        "i915.fastboot=1"
        "mem_sleep_default=deep"
      ];
    })

    (mkIf (cfg.enable && cfg.enableMediaAccel) {
      environment.variables = {
        VDPAU_DRIVER = "va_gl";
        LIBVA_DRIVER_NAME = "iHD";
      };
    })

    (mkIf (cfg.enable && cfg.enableThermal) {
      services.thermald.enable = true;
      services.throttled.enable = true;
      
      environment.etc."throttled.conf".text = ''
        [GENERAL]
        Enabled = true
        [UNDERVOLT.BATTERY]
        CPU = -75
        GPU = -50
        CACHE = -75
        [UNDERVOLT.AC]
        CPU = -50
        GPU = -25
        CACHE = -50
      '';
    })
  ];
}
