{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "footclient";
      };
    };
  };

  home.file."scripts/sysact" = {
    enable = true;
    executable = true;
    source = ./sysact;
  };
}

