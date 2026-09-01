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

    # Prefer nearby mirrors, then fall back to the official cache.
    substituters = lib.mkForce [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];

    auto-optimise-store = true;
  };

  programs.nh = {
    enable = true;
    flake = "/home/${host.user.name}/tronsole";

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
