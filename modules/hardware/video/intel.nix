{ config, pkgs, lib, ... }:

{
  options.hardware.intel = {
    enable = lib.mkEnableOption "Intel hardware configuration";
    powerProfile = lib.mkOption {
      type = lib.types.enum ["balanced" "powersave" "performance"];
      default = "balanced";
      description = "Default CPU power profile";
    };
  };

  config = lib.mkIf config.hardware.intel.enable {
    # Graphics Configuration
    services.xserver.videoDrivers = [ "modesetting" ];
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver  # For hardware video acceleration
        vaapi-intel-hybrid   # Intel driver for the VAAPI library with partial HW acceleration
        libvdpau-va-gl  # VDPAU driver with OpenGL/VAAPI backend
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.intel-vaapi-driver 
        driversi686Linux.libvdpau-va-gl
      ];
    };

    # Power Management
    powerManagement = {
      enable = true;
      cpuFreqGovernor = config.hardware.intel.powerProfile;
      powertop.enable = true;
    };

    boot.kernelParams = [
      "i915.enable_guc=2"       # Enable GuC/HuC firmware loading
      "i915.enable_psr=1"       # Panel Self Refresh for power savings
      "i915.fastboot=1"         # Skip unnecessary mode sets at boot
      "mem_sleep_default=deep"  # Allow deepest sleep states
    ];

      
      # Thermal Management
      services.thermald.enable = true;
      services.throttled.enable = true;


    # Dell-specific hardware support
    hardware.enableRedistributableFirmware = true;


    # System optimizations for low RAM
    zramSwap.enable = true;
    services.earlyoom.enable = true;
  };
}
