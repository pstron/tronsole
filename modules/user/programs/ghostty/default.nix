{
  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = 0.6;
      window-decoration = false;
      window-padding-x = 10;
      font-family = "JetBrainsMono Nerd Font";
      font-size = 11;
      font-feature = "-calt, -liga, -dlig";
      cursor-opacity = 0.8;
      mouse-hide-while-typing = true;
      link-url = true;
      quit-after-last-window-closed = false;
      confirm-close-surface = false;
      custom-shader-animation = "always";
      custom-shader = "shaders/cursor_warp.glsl";
    };
  };

  xdg.configFile."ghostty/shaders/cursor_warp.glsl".source = ./cursor_warp.glsl;
}
