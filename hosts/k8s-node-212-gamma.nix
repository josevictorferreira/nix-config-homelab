{ ... }:

{
  imports = [
    ./../modules/hardware/intel-nuc-vm.nix
    ./base.nix
    ./../modules/roles/k8s-master.nix
  ];

  networking.hostName = "k8s-node-211-gamma";
  networking.staticIP = {
    enable = true;
    interface = "ens18";
    address = "10.10.10.212";
  };
}
