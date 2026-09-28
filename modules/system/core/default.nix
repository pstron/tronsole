{
  config,
  lib,
  pkgs,
  host,
  ...
}:

{
  # Keep the NixOS state-version explicit and host-owned.
  system.stateVersion = host.stateVersion;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Host-owned: see hosts/<name>/variables.nix -> nix.substituters.
    substituters = lib.mkForce host.nix.substituters;

    auto-optimise-store = true;
  }
  // lib.optionalAttrs (host.nix.trustedPublicKeys != [ ]) {
    trusted-public-keys = host.nix.trustedPublicKeys;
  };

  programs.nh = {
    enable = true;
    flake = "${host.user.homeDirectory}/tronsole";

    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 7d --keep 10";
    };
  };

  time.timeZone = host.locale.timeZone;
  i18n.defaultLocale = host.locale.defaultLocale;

  console = {
    keyMap = host.desktop.keyboard.layout;
  };

  system.copySystemConfiguration = false;

  # Keep the base shell available for system tools, but do not install a
  # second shell configuration here; the user's zsh setup belongs in HM.
  programs.zsh.enable = true;

  security.sudo.wheelNeedsPassword = true;
}
