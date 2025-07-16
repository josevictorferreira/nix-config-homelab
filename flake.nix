{
  description = "My Raspberry Pi 4 NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";
  };

  outputs = { self, nixpkgs, flake-utils, proxmox-nixos, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.git pkgs.nixos-rebuild ];
        };
      }) // {
        nixosConfigurations.raspberry-pi4 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./modules/hardware/raspberry-pi4.nix
            ./modules/hardware/shared-storage.nix
            ./hosts/raspberry-pi4.nix
            proxmox-nixos.nixosModules.proxmox-ve
            ({ pkgs, lib, ... }: {
              services.proxmox-ve = {
                enable = true;
                ipAddress = "10.10.10.209";
              };

              nixpkgs.overlays = [
                proxmox-nixos.overlays."aarch64-linux"
              ];
            })
          ];
        };
      };
}
