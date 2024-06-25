{
  description = "nixos config";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # stylix
    stylix.url = "github:danth/stylix";

    # nixvim
    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, stylix, nixvim, ... }:
    let
      overlay-unstable = system: final: prev: {
        unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
      };

      mkSystem = name: cfg: nixpkgs.lib.nixosSystem rec {
        system = cfg.system or "x86_64-linux";
        #specialArgs = inputs;
        modules = [
          ({ ... }: { nixpkgs.overlays = [ (overlay-unstable system) ]; })

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
            home-manager.users.hazel.imports = [
              {
                programs.home-manager.enable = true;
              }

              stylix.homeManagerModules.stylix

              ./home/hosts/${name}.nix
            ];
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

