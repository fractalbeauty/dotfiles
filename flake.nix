{
  description = "nixos config";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixpkgs master
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    # home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nixos-wsl
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    # stylix
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";

    # nixvim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # nix-vscode-extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    # quickshell
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-wsl, stylix, nixvim, ... }:
    let
      masterOverlay = final: prev: {
        inherit (inputs.nixpkgs-master.legacyPackages.${prev.system}) jetbrains;
      };

      mkSystem = name: cfg: nixpkgs.lib.nixosSystem rec {
        system = cfg.system or "x86_64-linux";
        
        #specialArgs = inputs;
        modules = [
          ./nixos/lemurs.nix

          ({ ... }: {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.overlays = [ masterOverlay ];
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

              stylix.homeModules.stylix

              ./hosts/${name}/home.nix
            ];
          }
        ] ++ (cfg.modules or []);
      };

      systems = {
        momoe = {
          modules = [];
        };
        ai = {
          modules = [
            nixos-wsl.nixosModules.default
          ];
        };
      };
    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem systems;
    };
}

