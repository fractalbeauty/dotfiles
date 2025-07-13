{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../nixos/android.nix
    ../../nixos/battery.nix
    ../../nixos/bluetooth.nix
    ../../nixos/common.nix
    ../../nixos/gaming.nix
    ../../nixos/ime.nix
    ../../nixos/podman.nix
    ../../nixos/tailscale.nix
  ];

  # systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  security.polkit.enable = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # pipewire
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # system packages
  environment.systemPackages = with pkgs; [
    dconf
    config.boot.kernelPackages.perf
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  users.users.hazel = {
    isNormalUser = true;
    home = "/home/hazel";
    extraGroups = [ "wheel" "networkmanager" "ydotool" ];
  };

  hardware.graphics.enable = true;

  # virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "hazel" ];

  # envfs
  services.envfs.enable = true;

  # lemurs
  # TODO
  # services.lemurs = {
  #   enable = true;
  #   settings = {
  #     #
  #   };
  #   river.enable = true;
  # };

  # fprintd
  services.fprintd.enable = true;

  # waylock
  security.pam.services.waylock = {};

  # ydotool
  programs.ydotool.enable = true;

  # xdg-desktop-portal
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];

  # gvfs for nemo
  services.gvfs.enable = true;

  # nixos state version
  system.stateVersion = "24.05";
}

