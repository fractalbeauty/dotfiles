{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.qmk
    pkgs.via
  ];
  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];
}
