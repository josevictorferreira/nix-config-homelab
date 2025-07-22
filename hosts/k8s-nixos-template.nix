{ ... }:

{
  imports = [
    ./../modules/hardware/intel-nuc-vm.nix
    ./base.nix
  ];

  networking.hostName = "k8s-nixos-template";
  networking.staticIP = {
    enable = true;
    interface = "ens18";
    address = "10.10.10.250";
  };
}
