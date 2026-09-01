{ lib, host, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = host.user.name;
      user.email = lib.mkIf (host.user.gitEmail != null) host.user.gitEmail;
      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
    };
  };
}
