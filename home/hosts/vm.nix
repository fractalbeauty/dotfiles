{ pkgs, ... }:

{
  imports = [
    ../river/river.nix
    ../foot.nix
    ../firefox.nix

    ../zsh.nix
    ../nvim.nix
    ../utils.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}

