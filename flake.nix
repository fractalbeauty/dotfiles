{
  description = "nixos config";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # home-manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nixvim
    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, nixvim, ... }:
    let
      mkSystem = name: cfg: nixpkgs.lib.nixosSystem {
        system = cfg.system or "x86_64-linux";
        #specialArgs = inputs;
        modules = [
          # shared configuration for all hosts 
          {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            #networking.hostName = name;
          }

          ./hosts/${name}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.hazel.imports = [ ./home/hosts/${name}.nix ];
          }
        ] ++ (cfg.modules or []);
      };

      systems = {
        vm = {
          modules = [];
        };
      };
    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem systems;
    };
}

