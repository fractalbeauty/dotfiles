{
  description = "nixos config";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # home-manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager,  ... }:
    let
      mkSystem = name: cfg: nixpkgs.lib.nixosSystem {
        system = cfg.system or "x86_64-linux";
        specialArgs = inputs;
        modules = [
          # shared configuration for all hosts 
          {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            #networking.hostName = name;
          }

          ./hosts/${name}
        ]
          ++ (cfg.modules or [])
          ++ (nixpkgs.lib.optionals (cfg.home-manager) [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.hazel = import ./home/profiles/vm.nix;
            }
          ]);
      };

      systems = {
        vm = {
          modules = [];
          home-manager = true;
        };
      };
    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem systems;
    };
}

