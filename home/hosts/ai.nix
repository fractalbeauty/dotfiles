{ inputs, pkgs, ... }:

{
  imports = [
    ../zsh.nix
    ../nvim.nix
    ../utils.nix
  ];

  home.packages = with pkgs; [
    podman-tui
  ];

  home.stateVersion = "24.05";
}
