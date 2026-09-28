# mihomo

Enabling the service in a host config is not enough: the proxy subscription is
not part of this repository (and must not be). Put the file in place once per
machine:

```bash
sudo install -Dm600 assets/mihomo/config.yaml.example /etc/mihomo/config.yaml
$EDITOR /etc/mihomo/config.yaml      # set proxy-providers.airport.url
sudo systemctl restart mihomo
```

`/etc/mihomo/config.yaml` is untracked state, so it has to be recreated after a
fresh install. Everything else (TUN, DNS, polkit, firewall) is declared in
`modules/system/services/mihomo/default.nix`.
