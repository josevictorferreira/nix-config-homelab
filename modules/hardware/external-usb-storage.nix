{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btrfs-progs
  ];

  boot.supportedFilesystems = [ "btrfs" ];

  fileSystems."/mnt/backup-storage" = {
    device = "/dev/disk/by-uuid/0a86fe93-c3c7-4e6d-acef-54dca7fdb4a6";
    fsType = "btrfs";
    options = [
       "nofail"
       "x-systemd.automount"
       "x-systemd.idle-timeout=600"
       "compress=zstd"
       "ssd"
    ];
  };
}
