{ config, ... }:

let
  clusterConfig = import ./../../shared/cluster-config.nix;
  masterInitHostname = clusterConfig.masters [ 0 ];
  serverAddress = (import ./../../hosts/${clusterConfig.masters[0]}.nix).networking.staticIP.address;
  selfHostname = config.networking.hostName;
  isInit = selfHostname == masterInitHostname;
  initFlags = [
    "--cluster-init"
    "--disable=traefik,servicelb"
  ];
in
{
  networking.firewall.allowedTCPPorts = clusterConfig.portsTcpToExpose;
  networking.firewall.allowedUDPPorts = clusterConfig.portsUdpToExpose;

  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = clusterConfig.tokenFile;
    serverAddr = "https://${serverAddress}:6443";
    extraFlags = toString [
    ] ++ (if isInit then initFlags else [ ]);
  };
}
