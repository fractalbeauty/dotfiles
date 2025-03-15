{ pkgs, ... }:

{
  # podman
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # podman-compose, podman-tui
  environment.systemPackages = with pkgs; [
    podman-compose
    podman-tui
  ];
}

