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
      modules = nixpkgs.lib.pipe ./modules [
      builtins.readDir
      (nixpkgs.lib.filterAttrs (name: _: nixpkgs.lib.hasSuffix ".nix" name))
      (nixpkgs.lib.mapAttrsToList (name: _: ./modules + "/${name}"))
      ];
    in
    {
      nixosConfigurations = {
        tidy = nixpkgs.lib.nixosSystem {
          # TODO: check if this can be set globally
          system = "x86_64-linux";
          modules = [
            ./machines/lil-thinkpad/configuration.nix
            {
              _module.args = {
                inherit inputs;
              };
            }
          ] ++ modules;
        };

        kidy = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/kde-thinkpad/configuration.nix
            {
              _module.args = {
                inherit inputs;
              };
            }
          ] ++ modules;
        }
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
