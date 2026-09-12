{
  host,
  inputs,
  pkgs,
  ...
}:

let
  userName = host.user.name;
in
{
  # The host file intentionally does little more than:
  #   1. import hardware
  #   2. select system capabilities
  #   3. define the user
  #
  # All host-specific knobs live in variables.nix.

  networking.hostName = host.hostname;

  imports = [
    ./hardware-configuration.nix

    # System capability bundle. Host-specific values live in variables.nix.
    ../../modules/system
  ];

  users.users.${userName} = {
    isNormalUser = true;
    description = host.user.description;
    home = host.user.homeDirectory;
    createHome = true;
    extraGroups = host.user.extraGroups;
    shell = pkgs.zsh;
  };

  # Home Manager is deliberately composed here rather than hidden in a root
  # home/<user> tree. A host explicitly decides which user capabilities it gets.
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit host inputs;
    };

    users.${userName} = {
      imports = [ ../../modules/user ];

      home.username = userName;
      home.homeDirectory = host.user.homeDirectory;
      home.stateVersion = host.stateVersion;
    };
  };
}
