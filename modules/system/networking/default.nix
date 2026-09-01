{ host, ... }:

{
  networking.networkmanager.enable = host.networking.networkManager;

  networking.networkmanager.unmanaged = host.networking.unmanagedInterfaces;
}
