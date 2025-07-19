{
  description = "My Raspberry Pi 4 NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
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
            ./modules/hardware/external-usb-storage.nix
            ./hosts/raspberry-pi4.nix
          ];
        };
      };
}
