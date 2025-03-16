{
  inputs = {
    systems.url = "github:nix-systems/default";
  };

  outputs =
    { systems, nixpkgs, ... }@inputs:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs

            pkgs.corepack

            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server
          ];
        };
        elm = pkgs.mkShell {
          buildInputs = [
            pkgs.elmPackages.elm
            pkgs.elmPackages.elm-format
          ];
        };
      });
    };
}

