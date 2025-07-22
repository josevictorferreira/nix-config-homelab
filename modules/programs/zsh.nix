{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableLsColors = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      l = "ls -l";
      gs = "git status";
      gcmsg = "git commit -m ";
      gp = "git push";
      gl = "git pull";
      gpr = "git pull --rebase";
    };
    histSize = 10000;
  };
}
