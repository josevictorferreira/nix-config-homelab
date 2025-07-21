{ ... }: {
  system.copySystemConfiguration = true; # make a copy of current system configuration to /run/current-system/configuration.nix in case of a accidental deletion
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
} 
