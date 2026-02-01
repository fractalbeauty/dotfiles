{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, fenix, ... }:
    let
      eachSupportedSystem = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      devShells = eachSupportedSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          f = fenix.packages.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              (f.stable.withComponents [
                "cargo"
                "clippy"
                "rust-src"
                "rustc"
                "rustfmt"
              ])
            ];
          };
        }
      );
    };
}
