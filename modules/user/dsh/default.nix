{
  config,
  host,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  # The materialized name (`nix-web`) is what both the CLI default profile and
  # the service must reference; see the profile options for the `nix-` prefix.
  profile = config.programs.dsh.profiles.web.materializedName;
in
{
  imports = [
    inputs.deepseek-harness.homeModules.default
  ];

  # The upstream `web` preset: the harness with the web app bundle and without
  # the optional community UI bundles.
  programs.dsh = lib.mkIf host.dsh.enable {
    enable = true;
    defaultProfile = profile;

    profiles.web.bundles = with pkgs.dsh.bundles; [
      web-app
    ];
  };

  # Keep the web service in the user manager so it shares $DSH_HOME with the
  # CLI; the system-level service would start from an empty data directory.
  services.dsh = lib.mkIf host.dsh.enable {
    enable = true;
    profile = profile;
    port = host.dsh.port;
  };
}
