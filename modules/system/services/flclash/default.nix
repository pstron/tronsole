{
  lib,
  pkgsStable,
  host,
  ...
}:

lib.mkIf host.applications.flclash (
  let
    flclash = pkgsStable.flclash.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        substituteInPlace lib/common/path.dart \
          --replace-fail \
          "return join(executableDirPath, 'FlClashCore\$executableExtension');" \
          "return '/run/wrappers/bin/FlClashCore';"
      '';
    });
  in
  {
    environment.systemPackages = [ flclash ];

    networking.networkmanager.unmanaged = lib.mkAfter [
      "interface-name:FlClash"
    ];

    security.wrappers.FlClashCore = {
      source = "${pkgsStable.flclash.core}/bin/FlClashCore";

      owner = "root";
      group = "root";
      setuid = true;
      permissions = "u+rwx,g+rx,o+rx";
    };
  }
)
