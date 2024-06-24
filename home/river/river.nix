{ ... }:

{
  wayland.windowManager.river.enable = true;
  wayland.windowManager.river.extraConfig = builtins.readFile ./init;
}

