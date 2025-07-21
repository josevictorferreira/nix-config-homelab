{ pkgs, ... }:
{
  users.users.josevictor = {
    isNormalUser = true;
    home = "/home/josevictor";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = import ../keys/josevictor.nix;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
