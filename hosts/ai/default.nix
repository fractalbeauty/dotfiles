{ config, lib, pkgs, ... }:

{
  imports = [
    ../../nixos/common.nix
    ../../nixos/podman.nix
    ../../nixos/tailscale.nix
  ];

  # nixos-wsl
  wsl.enable = true;
  wsl.defaultUser = "hazel";

  users.users.hazel = {
    isNormalUser = true;
    home = "/home/hazel";
    extraGroups = [ "wheel" ];
  };

  # envfs
  services.envfs.enable = true;

  # fix for vscode in wsl
  programs.nix-ld = {
    enable = true;
  };

  # nixos state version
  system.stateVersion = "24.05";
}

