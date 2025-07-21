{ ... }:

{
  imports = [
    ./hardware.nix
    ./../base.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "k8s-node-alpha-210";
  networking.staticIP = {
    enable = true;
    interface = "ens18";
    address = "10.10.10.210";
  };
  services.qemuGuest.enable = true;
  services.cloud-init.enable = true;
}
