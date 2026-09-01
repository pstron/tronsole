{
  programs.fastfetch.enable = true;

  xdg.configFile."fastfetch/config.jsonc".source = ./config.jsonc;
  xdg.configFile."fastfetch/sanitized.jsonc".source = ./sanitized.jsonc;
}
