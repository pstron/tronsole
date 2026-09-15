{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    fastSyntaxHighlighting = {
      enable = true;
      theme = "default";
    };

    defaultKeymap = "viins";

    history = {
      path = "${config.home.homeDirectory}/.zhistory";
      size = 10000;
      save = 10000;
      ignoreDups = true;
      ignoreSpace = true;

      ignorePatterns = [
        "l"
        "la"
        "ls"
        "cd"
        "pwd"
        "exit"
        "history"
        "cd -"
        "cd .."
      ];
    };

    shellAliases = {
      _ = "sudo ";
      pls = "sudo";

      gc1 = "git clone --recursive --depth=1";
      md = "mkdir -p";

      lls = "${pkgs.coreutils}/bin/ls";
      ls = "eza --color=auto";
      l = "eza -lbah --icons";
      la = "eza -labgh --icons";
      ll = "eza -lbg --icons";
      lsa = "eza -lbagR --icons";
      lst = "eza -lTabgh --icons";

      lcat = "${pkgs.coreutils}/bin/cat";
      cat = "bat -pp";
    };

    plugins = [
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
    ];

    initContent = ''
      setopt correct interactive_comments
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    fileWidget.command = "fd --type f";
    changeDirWidget.command = "fd --type d";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship.enable = true;
}
