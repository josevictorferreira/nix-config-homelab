{ config, pkgs, lib, ... }:

let
    pveNodes = [
        { name = "pve1"; ip = "10.10.10.200"; mac = "68:1D:EF:30:C1:03"; }
        { name = "pve2"; ip = "10.10.10.201"; mac = "68:1D:EF:3B:71:4E"; }
        { name = "pve3"; ip = "10.10.10.202"; mac = "68:1D:EF:3E:30:37"; }
    ];

    mkPveService = node: {
        "systemd.services.pve-wol-${node.name}" = {
            description = "Check if ${node.name} is online and send WoL if down";
            serviceConfig = {
                Type = "oneshot";
                ExecStart = pkgs.writeShellScript "pve-wol-${node.name}" ''
                    if ! ping -c 1 -W 1 ${node.ip} > /dev/null; then
                        echo "${node.name} is offline. Sending WoL..."
                        ${pkgs.wakeonlan}/bin/wakeonlan ${node.mac}
                    else
                        echo "${node.name} is online."
                    fi
                '';
            };
        };

        "systemd.timers.pve-wol-${node.name}" = {
            wantedBy = [ "timers.target" ];
            timerConfig = {
                OnUnitActiveSec = "5min";
                Persistent = true;
            };
        };
    };

    allServices = lib.foldl (acc: node: acc // mkPveService node) {} pveNodes;

in
{
    environment.systemPackages = [ pkgs.wakeonlan ];
    
    systemd.services = allServices.systemd.services or {};
    systemd.timers = allServices.systemd.timers or {};
}
