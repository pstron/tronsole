# Every machine-specific value of this host lives here. Nothing else in the
# repository should need editing to make this host your own.
#
# Replace every CHANGE-ME. The directory name (hosts/<name>) is the flake
# attribute name, i.e. `.#<name>`; keep `hostname` equal to it.
{
  # --- identity -------------------------------------------------------------
  hostname = "CHANGE-ME"; # networking.hostName
  system = "x86_64-linux"; # or aarch64-linux
  stateVersion = "26.05"; # the release this machine was installed with; never change it later

  # --- user ----------------------------------------------------------------
  user = {
    name = "user"; # account name, also the Home Manager user
    description = "user";
    homeDirectory = "/home/user";
    gitEmail = "you@example.com"; # programs.git; null to skip
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # --- nix -----------------------------------------------------------------
  nix = {
    # Binary caches, nearest first. modules/system/core applies them with mkForce.
    substituters = [ "https://cache.nixos.org" ];
    # Only needed for a cache that is not signed by the official key.
    trustedPublicKeys = [ ];
  };

  # --- theme ---------------------------------------------------------------
  theme = {
    flavor = "mocha"; # catppuccin: latte, frappe, macchiato, mocha
    accent = "mauve";
  };

  # --- locale --------------------------------------------------------------
  locale = {
    timeZone = "UTC";
    defaultLocale = "en_US.UTF-8";
  };

  # --- desktop -------------------------------------------------------------
  desktop = {
    monitor = {
      # Leave output empty to make this the fallback rule in Hyprland.
      output = "";
      resolution = "1920x1080";
      refreshRate = 60;
      scale = 1.0;
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
      # SDDM's Wayland greeter is still more failure-prone than its X11
      # greeter; the session itself can still be Wayland/Hyprland.
      waylandGreeter = false;
    };
  };

  # --- laptop --------------------------------------------------------------
  laptop = {
    enable = false; # true = TLP, upower, iio sensors, brightnessctl

    # Change these only after confirming the firmware exposes a compatible
    # battery name and charge-threshold interface.
    tlp = {
      startChargeThreshold = 40;
      stopChargeThreshold = 80;
    };

    iio = false; # accelerometer / light sensor
  };

  # --- boot ----------------------------------------------------------------
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

  # --- networking ----------------------------------------------------------
  networking = {
    networkManager = true;
  };

  # --- flatpak -------------------------------------------------------------
  flatpak = {
    enable = false;
    remote = {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };
    packages = [
      # "com.tencent.WeChat"
      # "com.qq.QQ"
    ];
  };

  # --- applications --------------------------------------------------------
  applications = {
    firefox = true;
    localsend = false;
    mihomo = false; # needs /etc/mihomo/config.yaml, see docs/mihomo.md
  };

  # --- deepseek harness (per-user web service) -----------------------------
  # The web profile keeps $DSH_HOME (~/.dsh) shared with the CLI, so
  # interactive sessions and credentials carry over.
  dsh = {
    enable = false;
    port = 3080;
  };
}
