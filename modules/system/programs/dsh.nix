{
  host,
  inputs,
  lib,
  ...
}:

# `home-manager.useGlobalPkgs = true` resolves `pkgs.dsh` from the NixOS-level
# package set, so the deepseek-harness overlay has to be added here rather than
# inside the user module that consumes `programs.dsh` and its bundles.
lib.mkIf host.dsh.enable {
  nixpkgs.overlays = [
    inputs.deepseek-harness.overlays.default
  ];
}
