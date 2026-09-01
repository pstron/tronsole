{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    okular
    elisa
    qrca
  ];

  xdg.portal = {
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config.kde.default = [
      "kde"
      "gtk"
    ];
  };
}
