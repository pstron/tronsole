<p align="center">
  <img src="assets/nixos_btw.png" alt="tronsole" width="720">
</p>

# tronsole

A NixOS + Home Manager flake, kept as a template: `main` holds one example host
with no real machine data, and actual machines live on branches on top of it.

## Use it

```bash
git clone https://github.com/pstron/tronsole.git && cd tronsole
cp -r hosts/template hosts/mymachine
sudo nixos-generate-config --show-hardware-config > hosts/mymachine/hardware-configuration.nix
$EDITOR hosts/mymachine/variables.nix     # replace every CHANGE-ME
git add hosts/mymachine                   # flakes only see files git tracks
nixos-rebuild build --flake .#mymachine   # use switch when the build looks right
```

`hosts/<name>/variables.nix` is the whole machine description, and its comments
say which module reads each value. For everything else, read the module you are
about to change.

## Branches

- `main` — template only: `hosts/template`, every value a `CHANGE-ME`
  placeholder. Real host data never goes here.
- `pstron` — this repository's personal branch: `main` plus one real host
  directory. That directory is the only difference between the branches.

Keep a personal branch current with `git checkout <branch> && git rebase main`.

## Manual steps

Things the configuration cannot do for you:

- [docs/mihomo.md](docs/mihomo.md) — the proxy needs a config file that is not
  and should not be in this repository.
