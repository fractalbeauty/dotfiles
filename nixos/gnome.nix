{ config, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.systemPackages = [
    pkgs.gnomeExtensions.dash-to-panel
    pkgs.gnome-tweaks
  ];
}
