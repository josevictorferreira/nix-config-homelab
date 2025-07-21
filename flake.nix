{
  description = "My Homelab Machines NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, ... }@inputs:
    let
      hosts = {
        rpi4 = "aarch64-linux";
        k8s-node-alpha-210 = "x86_64-linux";
      };

      mkHost = hostName:
        nixpkgs.lib.nixosSystem {
          system = hosts.${hostName};
          specialArgs = { inherit inputs hostName; };
          modules = [
            ./hosts/${hostName}/configuration.nix
          ];
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (_: mkHost) hosts;
    };
}

