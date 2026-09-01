{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lsd
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    eza.enable = true;
    fd.enable = true;
    less.enable = true;
    # lsd.enable = true;
    ripgrep.enable = true;
    tmux.enable = true;
    yazi.enable = true;
    home-manager.enable = true;
  };
}
