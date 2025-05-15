{...}: {
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave"; # schedutil powersave, ondemand

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power"; # power, balance_power
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance"; # balance_performance

      PLATFORM_PROFILE_ON_AC = "performance"; # balance, performance
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 3;

      RUNTIME_PM_ON_AC = "auto"; # on, auto
      RUNTIME_PM_ON_BAT = "auto";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;

      # Protect battery
      START_CHARGE_THRESH_BAT0 = 82;
      STOP_CHARGE_THRESH_BAT0 = 95;
      START_CHARGE_THRESH_BAT1 = 82;
      STOP_CHARGE_THRESH_BAT1 = 95;
    };
  };
}
