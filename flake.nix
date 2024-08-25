{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
    let 
      modules = import ./modules/all.nix { inherit (nixpkgs) lib; };
    in
    {
      nixosConfigurations = {
        tidy = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/lil-thinkpad/configuration.nix
            {
              _module.args = {
                inherit inputs;
              };
            }
          ] ++ modules.nixos;
        };
      };
    # nixosConfigurations.default = nixpkgs.lib.nixosSystem {
    #   specialArgs = {inherit inputs;};
    #   modules = [
    #     ./configuration.nix
    #     ./modules/hyprland.nix
    #     ./modules/shell.nix
    #     ./modules/base.nix
    #     ./modules/private.nix
    #     # inputs.home-manager.nixosModules.default
    #   ];
    # };
    # nixosConfigurations.gaming = nixpkgs.lib.nixosSystem {
    #   specialArgs = {inherit inputs;};
    #   modules = [
    #     ./configuration.nix
    #     ./modules/hyprland.nix
    #     ./modules/shell.nix
    #     ./modules/base.nix
    #     ./modules/gaming.nix
    #     # inputs.home-manager.nixosModules.default
    #   ];
    # };
  };
}
