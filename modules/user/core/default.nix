{ config, ... }:

{
  xdg.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "ghostty";
    BROWSER = "firefox";
    BAT_PAGER = "less -m -RFQ";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];
}
