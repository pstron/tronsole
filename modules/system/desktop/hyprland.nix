{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.hyprland.default = [
      "hyprland"
      "gtk"
    ];
  };
}
