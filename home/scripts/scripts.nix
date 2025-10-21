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

  home.sessionPath = [ "$HOME/scripts" ];

  home.file."scripts/sysact" = {
    enable = true;
    executable = true;
    source = ./sysact;
  };
  home.file."scripts/useshell" = {
    enable = true;
    executable = true;
    source = ./useshell;
  };
}
