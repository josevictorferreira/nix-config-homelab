{ clusterConfig, ... }:

let
  masterHostname = builtins.head clusterConfig.masters;
  serverAddress = clusterConfig.hosts.${masterHostname}.ipAddress;
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
