# Machine-specific filesystem and kernel-module layout.
#
# Do not fill this in by hand. Generate the real file on the target machine:
#
#   sudo nixos-generate-config --show-hardware-config > hosts/<name>/hardware-configuration.nix
#
# The placeholder UUIDs below only keep `nix eval` working; they are not
# bootable and must be replaced by the generated file.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/CHANGE-ME-ROOT-UUID";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CHANGE-ME-EFI-UUID";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
