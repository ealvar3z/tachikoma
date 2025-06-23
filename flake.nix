{
  description = "eax's linux system(s)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable-small";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
    pipewire-screenaudio.inputs.nixpkgs.follows = "nixpkgs";

    vacme-vim = {
      url = "github:olivertaylor/vacme";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        "tachikoma" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./tachikoma-hardware.nix
            ./prefs.nix
            ./nix.nix
            ./tachikoma.nix
            ./home.nix
          ];
        };
        iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix"
            "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
          ];
        };
      };
    };
}
