{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "footclient";
        dpi-aware = "no";
      };
    };
  };

  home.file."scripts/sysact" = {
    enable = true;
    executable = true;
    source = ./sysact;
  };
}
