{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    file
    pciutils
    usbutils
    unzip
    wget
    which
    zip
  ];
}
