{ host, ... }:

{
  imports = [
    ./dsh.nix
  ];

  programs.firefox.enable = host.applications.firefox;

  programs.localsend = {
    enable = host.applications.localsend;
    openFirewall = host.applications.localsend;
  };

  programs.dconf.enable = true;
  programs.htop.enable = true;
}
