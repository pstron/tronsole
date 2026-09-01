{ pkgs, host, ... }:

{
  boot.loader = {
    grub = {
      enable = host.boot.grub.enable;
      device = "nodev";
      efiSupport = host.boot.grub.efiSupport;
      useOSProber = host.boot.grub.useOSProber;
      gfxmodeEfi = host.boot.grub.gfxmodeEfi;
      default = host.boot.grub.default;
      memtest86.enable = host.boot.grub.memtest86;
      extraEntries = ''
        menuentry "UEFI Firmware Settings" {
          fwsetup
        }
      '';
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  boot.supportedFilesystems = host.boot.supportedFilesystems;

  # The system follows nixos-unstable, but the generic kernel package set is
  # used instead of forcing linuxPackages_latest.
  boot.kernelPackages = pkgs.linuxPackages;
}
