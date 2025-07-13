{ config, pkgs, ... }:

{
  imports = [
    ./../modules/programs/vim.nix
    ./../modules/programs/git.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "rpi4";
  networking.useDHCP = false;
  networking.interfaces.end0 = {
    ipv4.addresses = [{
      address = "10.10.10.209";
      prefixLength = 24;
    }];
  };
  networking.defaultGateway = "10.10.10.1";
  networking.nameservers = [ "10.10.10.100" "1.1.1.1" ];
  networking.firewall.enable = true;

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb.layout = "us";
  services.openssh.enable = true;

  users.users.josevictor = {
    isNormalUser = true;
    home = "/home/josevictor";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINLyucWDDYGQ4sg4biPGOTxXo9xoYCY816t4koLi07+x root@josevictor.me"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPAXdWHFx9UwUOXlapiVD0mzM0KL9VsMlblMAc46D9PV josevictor@josevictor-nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOVNsxVT6rzeyqZVlJVdQgKEzK2z0fOFNRZMAvQvBxbX josevictorferreira@macos-macbook"
    ];
    initialPassword = "teste123";
  };
  security.sudo.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    gnumake
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh.enable = true;

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
