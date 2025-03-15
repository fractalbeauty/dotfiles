{ config, lib, pkgs, ... }:

{
  imports = [
    ../../nixos/common.nix
    ../../nixos/tailscale.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "hazel";

  environment.systemPackages = with pkgs; [
    dconf

    podman-compose
  ];

  users.users.hazel = {
    isNormalUser = true;
    home = "/home/hazel";
    extraGroups = [ "wheel" ];
  };

  # podman
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
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

