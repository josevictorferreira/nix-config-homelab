{ ... }:

let
  clusterConfig = import ./../../shared/cluster-config.nix;
  masterInitHostname = builtins.head clusterConfig.masters;
  serverAddress = (import ./../../hosts/${masterInitHostname}.nix { }).networking.staticIP.address;
in
{
  networking.firewall.allowedTCPPorts = clusterConfig.portsTcpToExpose;
  networking.firewall.allowedUDPPorts = clusterConfig.portsUdpToExpose;

  services.k3s = {
    enable = true;
    role = "agent";
    tokenFile = clusterConfig.tokenFile;
    serverAddr = "https://${serverAddress}:6443";
  };
}
