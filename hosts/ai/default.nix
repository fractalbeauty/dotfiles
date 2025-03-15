{ config, lib, pkgs, ... }:

{
  imports = [
    ../../nixos/common.nix
    ../../nixos/podman.nix
    ../../nixos/tailscale.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "hazel";

  environment.systemPackages = with pkgs; [
    dconf
  ];

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

