{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.callPackage ./derivation.nix {})
  ];
}

