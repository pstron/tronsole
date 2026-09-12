{
  lib,
  pkgs,
  host,
  ...
}:

lib.mkIf host.applications.mihomo {
  services.mihomo = {
    enable = true;
    package = pkgs.mihomo;
    configFile = "/etc/mihomo/config.yaml";
    tunMode = true;
    webui = pkgs.metacubexd;
  };

  systemd.tmpfiles.rules = [
    "d /etc/mihomo 0755 root root - -"
  ];

  # mihomo's TUN backend (sing-tun) hands the TUN's DNS settings to
  # systemd-resolved by running `resolvectl`, which reaches resolved over the
  # D-Bus system socket.
  systemd.services.mihomo.serviceConfig.RestrictAddressFamilies =
    lib.mkForce "AF_INET AF_INET6 AF_NETLINK AF_UNIX";

  # The resolver that mihomo's fake-ip DNS answers through.
  services.resolved.enable = true;

  # Those `resolvectl` calls are gated behind polkit (auth_admin), while mihomo
  # runs as an unprivileged DynamicUser. Without this rule the DNS hand-off is
  # refused, the machine keeps asking the DHCP resolver directly, and fake-ip
  # and domain rules never apply. Name the caller by the capabilities of
  # resolvectl's parent (nixpkgs' `programs.throne` does the same), because a
  # DynamicUser has no stable name to match on. CAP_NET_ADMIN already permits
  # rewriting DNS, so this grants nothing that mihomo cannot already do.
  security.polkit = {
    enable = true;

    extraConfig = ''
      polkit.addRule(function(action, subject) {
        const allowedActionIds = [
          "org.freedesktop.resolve1.revert",
          "org.freedesktop.resolve1.set-dns-servers",
          "org.freedesktop.resolve1.set-domains",
          "org.freedesktop.resolve1.set-default-route"
        ];

        if (allowedActionIds.indexOf(action.id) !== -1) {
          try {
            var parentPid = polkit.spawn(["${lib.getExe' pkgs.procps "ps"}", "-o", "ppid=", subject.pid]).trim();
            var parentCap = polkit.spawn(["${lib.getExe' pkgs.libcap "getpcaps"}", parentPid]).trim();
            if (parentCap.includes("cap_net_admin")) {
              return polkit.Result.YES;
            } else {
              return polkit.Result.NOT_HANDLED;
            }
          } catch (e) {
            return polkit.Result.NOT_HANDLED;
          }
        }
      })
    '';
  };

  # Enabling resolved already points NetworkManager at it; the TUN device
  # itself has to stay unmanaged so NM does not wipe the DNS wiring above.
  networking.networkmanager.unmanaged = [
    "interface-name:Mihomo"
  ];

  # sing-tun's `system`/`mixed` TCP stack rewrites every connection into a new
  # inbound connection on the TUN device, which the default-deny input policy
  # drops. `stack: gvisor` does not need this, but keep the TUN trusted so
  # `system`, `mixed` and `auto-redirect` stay usable.
  networking.firewall.trustedInterfaces = [
    "Mihomo"
  ];
}
