{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    exfatprogs
  ];

  fileSystems."/mnt/backup-storage" = {
    device = "/dev/disk/by-uuid/9E94-9628";
    fsType = "exfat";
    options = [ "nofail" "x-systemd.automount" "x-systemd.idle-timeout=600" ];
  };
}
