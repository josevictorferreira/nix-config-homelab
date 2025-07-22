{ ... }:

{
  imports = [
    ./../modules/hardware/intel-nuc-vm.nix
    ./base.nix
  ];

  networking.hostName = "k8s-node-215-zeta";
  networking.staticIP = {
    enable = true;
    interface = "ens18";
    address = "10.10.10.215";
  };
}
