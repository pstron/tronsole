{
  pkgs,
  host,
  lib,
  ...
}:

let
  monitor = host.desktop.monitor;

  # hyprland.lua is a static file; the cursor size is injected here so it
  # cannot drift away from home.pointerCursor.size.
  hyprlandLua = lib.replaceStrings [ "@@CURSOR_SIZE@@" ] [ (toString host.desktop.cursor.size) ] (
    builtins.readFile ./hyprland.lua
  );
in
{
  home.packages = with pkgs; [
    hyprshot
    wofi
    libnotify
    brightnessctl
    hyprpicker
    grim
    slurp
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;

    systemd.enable = false;

    configType = "lua";

    extraConfig = ''
      -- Host-derived monitor configuration.
      hl.monitor({
        output   = "${monitor.output}",
        mode     = "${monitor.resolution}@${toString monitor.refreshRate}",
        position = "auto",
        scale    = "${toString monitor.scale}",
      })

      hl.config({
        input = {
          kb_layout = "${host.desktop.keyboard.layout}",
          kb_variant = "${host.desktop.keyboard.variant}",
          kb_options = "${host.desktop.keyboard.options}",
        },

        misc = {
          -- Hyprpaper is the sole wallpaper provider.
          force_default_wallpaper = 0,
          disable_hyprland_logo = true,
        },
      })

      ${hyprlandLua}
    '';

  };

  xdg.configFile."background".source = ../../../../assets/nixos_btw.png;

  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false;

      preload = [
        "${../../../../assets/nixos_btw.png}"
      ];

      wallpaper = [
        {
          monitor = "";
          path = "${../../../../assets/nixos_btw.png}";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        inhibit_sleep = 3;
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }

        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.hyprpolkitagent.enable = true;

  services.mako = {
    enable = true;

    settings = {
      sort = "-time";
      layer = "overlay";
      width = 420;
      height = 120;
      margin = 5;
      padding = "0,5,10";
      border-size = 1;
      border-radius = 15;
      icons = true;
      max-icon-size = 64;
      default-timeout = 5000;
      ignore-timeout = true;
    };
  };

  programs.hyprlock = {
    enable = true;
    extraConfig = builtins.readFile ./hyprlock.conf;
  };

  programs.waybar = {
    enable = true;
    systemd.enable = false;

    settings = [
      (builtins.fromJSON (builtins.readFile ./waybar.json))
    ];

    style = builtins.readFile ./waybar.css;
  };

  xdg.configFile."wofi/style.css".source = ./wofi.css;
}
