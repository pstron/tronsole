{
  pkgs,
  host,
  inputs,
  ...
}:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.pointerCursor = {
    enable = true;

    gtk.enable = true;
    x11.enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = host.desktop.cursor.size;
  };

  xdg.dataFile."fcitx5/rime/default.custom.yaml".text = ''
    patch:
      __include: rime_ice_suggestion:/
      __patch:
        menu/page_size: 6
  '';

  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
  };

  qt = {
    enable = true;
    style.name = "kvantum";
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = host.theme.flavor;
    accent = host.theme.accent;

    gtk.icon.enable = false;
  };
}
