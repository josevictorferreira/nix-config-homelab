{ pkgs, username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = import ../keys/${username}.nix;
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
