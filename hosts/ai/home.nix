{ inputs, pkgs, ... }:

{
  imports = [
    ../../home/nvim.nix
    ../../home/senpai.nix
    ../../home/utils.nix
    ../../home/zsh.nix
  ];

  home.stateVersion = "24.05";
}
