{ config, ... }:

{
  wayland.windowManager.river = {
    enable = true;
    settings = {
      background-color = "0x" + config.lib.stylix.colors.base00;
      border-color-focused = "0x" + config.lib.stylix.colors.base0D;
      border-color-unfocused = "0x" + config.lib.stylix.colors.base03;
      border-color-urgent = "0x" + config.lib.stylix.colors.base08;
    };
    extraConfig = builtins.readFile ./init;
  };
}

