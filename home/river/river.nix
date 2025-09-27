{ pkgs, config, inputs, ... }:

let
  colors = config.lib.stylix.colors;
  lockCommand = "waylock -fork-on-lock -ignore-empty-password -init-color 0x${colors.base00} -input-color 0x${colors.base0D} -fail-color 0x${colors.base08}";
in {
  home.packages = [
    pkgs.swayidle
    pkgs.sway-audio-idle-inhibit
    pkgs.waylock
    pkgs.brightnessctl
    pkgs.wl-clipboard
    pkgs.pamixer
    pkgs.wayshot
    pkgs.slurp

    inputs.quickshell.packages.${pkgs.system}.default
  ];

  wayland.windowManager.river = {
    enable = true;
    settings = {
      background-color = "0x" + colors.base00;
      border-color-focused = "0x" + colors.base0D;
      border-color-unfocused = "0x" + colors.base03;
      border-color-urgent = "0x" + colors.base08;

      map = {
        normal = {
          # run menu
          "Super R" = "spawn 'fuzzel -p Run:\\ '";
          # cliphist menu
          "Super V" = "spawn 'cliphist list | fuzzel -d -p Clipboard:\\ | cliphist decode | wl-copy'";
          # launch programs
          "Super+Shift Return" = "spawn footclient";
          "Super+Shift F" = "spawn firefox";
          "Super+Shift L" = "spawn '${lockCommand}'";
          "Super+Shift P" = "spawn ~/scripts/sysact";
          # brightness
          "Super+Control Up" = "spawn 'brightnessctl set 10%+'";
          "Super+Control Down" = "spawn 'brightnessctl set 10%-'";
          # volume
          "Super Up" = "spawn 'pamixer -i 5'";
          "Super Down" = "spawn 'pamixer -d 5'";
          "Super Left" = "spawn 'pamixer -t'";
          # screenshots
          "None Print" = "spawn 'wayshot --stdout | wl-copy'";
          "Super Print" = "spawn 'wayshot -s \"$(slurp)\" --stdout | wl-copy'";
          # insert datetime
          "Super+Shift T" = "spawn 'sleep 0.3 && echo -n `date +\"%Y-%m-%d %H:%M:%S\"` | ydotool type -f- -d5 -H5'";
        };
      };

      spawn = [
        "yambar"
        "'swayidle timeout 300 \"${lockCommand}\"'"
        "sway-audio-idle-inhibit"
        "'foot --server'"
        "fcitx5"
      ];
    };
    extraConfig = builtins.readFile ./init;
  };

  home.file."scripts/lock" = {
    enable = true;
    executable = true;
    text = ''
      #!/bin/sh
      ${lockCommand}
    '';
  };

  services.cliphist = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    config.common = {
      default = [ "gtk" ];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}

