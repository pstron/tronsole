{
  # Host identity
  hostname = "CHANGE-ME";
  system = "x86_64-linux";

  # NixOS and Home Manager state versions should normally stay at the
  # version the machine was installed with.
  stateVersion = "26.05";

  # Primary account for this host.
  user = {
    name = "user";
    description = "user";
    homeDirectory = "/home/user";
    gitEmail = "you@example.com";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  theme = {
    flavor = "mocha";
    accent = "mauve";
  };

  locale = {
    timeZone = "UTC";
    defaultLocale = "en_US.UTF-8";
  };

  # Display settings consumed by the Hyprland user module.
  desktop = {
    monitor = {
      # Keep output empty to let Hyprland apply this as the fallback monitor.
      output = "";
      resolution = "1920x1080";
      refreshRate = 60;
      scale = 1.33;
    };

    keyboard = {
      layout = "us";
      variant = "";
      options = "";
    };

    cursor = {
      size = 18;
    };

    sddm = {
      # SDDM's Wayland greeter is still more failure-prone than its X11 greeter.
      # The login session itself may still be fully Wayland/Hyprland.
      waylandGreeter = false;
    };
  };

  laptop = {
    enable = true;

    # Conservative battery policy. Change these after confirming the firmware
    # exposes a compatible battery name/charge-threshold interface.
    tlp = {
      startChargeThreshold = 40;
      stopChargeThreshold = 80;
    };

    # Enable this if your hardware exposes an accelerometer/light sensor.
    iio = true;
  };

  boot = {
    supportedFilesystems = [ "ntfs" ];
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      default = "saved";
      gfxmodeEfi = "1920x1080";
      memtest86 = true;
    };
  };

  networking = {
    networkManager = true;
  };

  # Keep Flatpak declarations in the host description so another host can
  # choose a different set without changing shared modules.
  flatpak = {
    enable = true;
    remote = {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };
    packages = [
      "com.tencent.WeChat"
      "com.qq.QQ"
    ];
  };

  applications = {
    firefox = true;
    localsend = true;
    mihomo = true;
  };

  # DeepSeek Harness, served as a per-user web service. The web profile keeps
  # $DSH_HOME (~/.dsh) shared with the CLI, so interactive sessions and
  # credentials carry over.
  dsh = {
    enable = true;
    port = 3080;
  };

}
