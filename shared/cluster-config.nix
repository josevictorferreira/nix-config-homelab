{
  clusterName = "homelab";

  masters = [
    "k8s-node-212-gamma"
  ];

  tokenFile = "/var/secrets/k3s_token";

  portsUdpToExpose = [
    8472
    51820
    51821
  ];

  portsTcpToExpose = [
    2379
    2380
    6443
    10250
  ];
}
