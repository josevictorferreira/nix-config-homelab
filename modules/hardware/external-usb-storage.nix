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

  systemd.services."mount-backup-drive" = {
    description = "Mount USB Backup Drive";
    serviceConfig.Type = "oneshot";
    script = ''
      mount /mnt/backup-storage
    '';
  };

  systemd.services."unmount-backup-drive" = {
    description = "Unmount USB Backup Drive";
    serviceConfig.Type = "oneshot";
    script = ''
      umount /mnt/backup-storage
    '';
  };

  systemd.timers."mount-backup-drive" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily 01:00";
      Persistent = true;
    };
  };

  systemd.timers."unmount-backup-drive" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily 07:00";
      Persistent = true;
    };
  };
}
