{ pkgs, config, ... }:

let
  colors = config.lib.stylix.colors;
  lockCommand = "waylock -fork-on-lock -ignore-empty-password -init-color 0x${colors.base00} -input-color 0x${colors.base0D} -fail-color 0x${colors.base08}";
in {
  home.packages = with pkgs; [
    swayidle
    sway-audio-idle-inhibit
    waylock
    brightnessctl
    wl-clipboard
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
          "Control+Shift Up" = "spawn 'brightnessctl set 10%+'";
          "Control+Shift Down" = "spawn 'brightnessctl set 10%-'";
        };
      };

      spawn = [
        "yambar"
        "'swayidle timeout 300 \"${lockCommand}\"'"
        "sway-audio-idle-inhibit"
        "'foot --server'"
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
}

