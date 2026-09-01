{ pkgs, ... }:

{
  home.packages = with pkgs; [
    chafa
    file-roller
    nemo
    nixd
    nixfmt
    pavucontrol
    playerctl
    vim-full
    wl-clipboard
  ];
}
