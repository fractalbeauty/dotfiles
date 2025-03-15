{ inputs, pkgs, ... }:

{
  imports = [
    ../zsh.nix
    ../nvim.nix
    ../utils.nix
  ];

  home.stateVersion = "24.05";
}
