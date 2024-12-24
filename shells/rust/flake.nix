{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, fenix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        f = fenix.packages.${system};
      in
        {
          devShells.default =
            pkgs.mkShell {
              buildInputs = with pkgs; [
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
}

