{ pkgs, config, ... }:

{
  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    monitor = "eDP-1, 1920x1200@60, 0x0, 1";
    "$mod" = "SUPER";
    "$modShift" = "SUPER_SHIFT";
    bind = [
      "$mod, Q, killactive,"
      "$modShift, Return, exec, foot"
      "$mod, M, exit,"
      "$mod, R, exec, fuzzel"
      "$modShift, F, exec, firefox"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      )
    );
  };
}
