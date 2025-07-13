{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    config = {
      user.name = "Jose Victor Ferreira";
      user.email = "root@josevictor.me";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      push.followTags = true;
      pull.rebase = true;
      url = {
        "ssh://git@github.com/" = {
          insteadOf = "https://github.com/";
        };
      };
      fetch = {
        prune = true;
        tags = true;
      };
    };
  };
}
