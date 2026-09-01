{
  lib,
  pkgs,
  host,
  ...
}:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = host.desktop.sddm.waylandGreeter;
  };

  services.xserver.excludePackages = [ pkgs.xterm ];

  services.orca.enable = false;

  services.libinput.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.udisks2.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  security.polkit.enable = true;

  security.pam.services.hyprlock = { };

  security.pam.services = {
    login = {
      kwallet.enable = lib.mkForce false;
      enableGnomeKeyring = lib.mkForce false;
    };

    sddm = {
      kwallet.enable = lib.mkForce false;
      enableGnomeKeyring = lib.mkForce false;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = host.theme.flavor;
    accent = host.theme.accent;

    sddm.enable = true;
    sddm.flavor = host.theme.flavor;
    sddm.accent = host.theme.accent;
  };
}
