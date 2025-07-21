{ ... }:

{
  imports = [
    ./hardware.nix
    ./../base.nix
    ./../../modules/roles/nfs-server.nix
    ./../../modules/services/wake-on-lan-observer.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "rpi4";
  networking.staticIP = {
    enable = true;
    interface = "end0";
    address = "10.10.10.209";
  };
}
