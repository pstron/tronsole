{
  lib,
  pkgs,
  host,
  ...
}:

lib.mkIf host.laptop.enable {
  services.power-profiles-daemon.enable = lib.mkForce false;

  services.tlp = {
    enable = true;

    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      START_CHARGE_THRESH_BAT0 = host.laptop.tlp.startChargeThreshold;
      STOP_CHARGE_THRESH_BAT0 = host.laptop.tlp.stopChargeThreshold;

      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      SOUND_POWER_SAVE_ON_BAT = 10;
      SOUND_POWER_SAVE_CONTROLLER = "Y";
    };
  };

  services.upower.enable = true;

  hardware.sensor.iio.enable = host.laptop.iio;

  environment.systemPackages = with pkgs; [
    brightnessctl
    powertop
  ];
}
