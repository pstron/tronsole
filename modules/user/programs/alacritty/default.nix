{
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        blink_interval = 550;
        unfocused_hollow = false;
        style = {
          blinking = "On";
          shape = "Block";
        };
      };

      selection.save_to_clipboard = false;

      window = {
        decorations = "none";
        dynamic_title = true;
        opacity = 0.7;
        padding = {
          x = 15;
          y = 15;
        };
      };

      font = {
        size = 10;
        normal.family = "JetBrainsMono Nerd Font";
        bold.family = "JetBrainsMono Nerd Font";
        italic.family = "JetBrainsMono Nerd Font";
        bold_italic.family = "JetBrainsMono Nerd Font";
      };

      general.live_config_reload = true;
    };
  };
}
