{ pkgs, ... }:

{
  imports = [
    ./../modules/common/nix.nix
    ./../modules/common/static-ip.nix
    ./../modules/common/locale.nix
    ./../modules/common/ssh.nix
    ./../modules/common/users.nix
    ./../modules/programs/vim.nix
    ./../modules/programs/git.nix
    ./../modules/programs/zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    gnumake
    htop
  ];
}
