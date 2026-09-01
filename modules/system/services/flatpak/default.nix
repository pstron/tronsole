{ lib, host, ... }:

lib.mkIf host.flatpak.enable {
  services.flatpak = {
    enable = true;

    remotes = [ host.flatpak.remote ];
    packages = host.flatpak.packages;
  };
}
