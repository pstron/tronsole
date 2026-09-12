{ host, ... }:

{
  networking.networkmanager.enable = host.networking.networkManager;
}
