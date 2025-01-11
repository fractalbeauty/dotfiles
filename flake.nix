{
  description = "nixos config";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # stylix
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";

    # nixvim
    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.home-manager.follows = "home-manager";

    # nix-vscode-extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, stylix, nixvim, ... }:
    let
      mkSystem = name: cfg: nixpkgs.lib.nixosSystem rec {
        system = cfg.system or "x86_64-linux";
        #specialArgs = inputs;
        modules = [
          ./modules/lemurs.nix

          ({ ... }: {
            nixpkgs.config.allowUnfree = true;
          })

          # shared configuration for all hosts 
          {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            networking.hostName = name;
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
        momoe = {
          modules = [];
        };
      };
    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem systems;
    };
}

