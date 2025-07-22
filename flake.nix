{
  description = "My Homelab Machines NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    sops-nix.url = "github:Mic92/sops-nix";
  };
  outputs = { self, nixpkgs, sops-nix, ... }@inputs:
    let
      flakeRoot = self;
      username = "josevictor";
      hosts = {
        rpi4 = "aarch64-linux";
        k8s-node-210-alpha = "x86_64-linux";
        k8s-node-211-beta = "x86_64-linux";
        k8s-node-212-gamma = "x86_64-linux";
        k8s-node-213-delta = "x86_64-linux";
        k8s-node-214-epsilon = "x86_64-linux";
        k8s-node-215-zeta = "x86_64-linux";
        k8s-node-216-eta = "x86_64-linux";
      };

      mkHost = hostName:
        nixpkgs.lib.nixosSystem {
          system = hosts.${hostName};
          specialArgs = {
            inherit self inputs hostName username flakeRoot;
          };
          modules = [
            sops-nix.nixosModules.sops
            ./hosts/${hostName}/configuration.nix
          ];
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (hostName: _system: mkHost hostName) hosts;
    };
}

