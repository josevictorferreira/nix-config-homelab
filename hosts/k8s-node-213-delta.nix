{ ... }:

{
  imports = [
    ./../modules/hardware/intel-nuc-vm.nix
    ./base.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "k8s-node-211-delta";
  networking.staticIP = {
    enable = true;
    interface = "ens18";
    address = "10.10.10.213";
  };
  services.qemuGuest.enable = true;
  services.cloud-init.enable = true;
}
