{ config, ... }:

let
  colors = config.lib.stylix.colors;

  riverTagBaseOld = {
    foreground = colors.base05 + "ff";
    left-margin = 8;
    right-margin = 8;
    default = { empty = {}; };
    conditions = {
      "id == 1" = { string = { text = "1"; }; };
      "id == 2" = { string = { text = "2"; }; };
      "id == 3" = { string = { text = "3"; }; };
      "id == 4" = { string = { text = "4"; }; };
      "id == 5" = { string = { text = "5"; }; };
      "id == 6" = { string = { text = "6"; }; };
      "id == 7" = { string = { text = "7"; }; };
      "id == 8" = { string = { text = "8"; }; };
      "id == 9" = { string = { text = "9"; }; };
    };
  };
  mkRiverTag = t: {
    foreground = colors.base0D + "ff";
    font = "Inconsolata Nerd Font:pixelsize=10";
    left-margin = 8;
    right-margin = 12;
    default = { empty = {}; };
    conditions = {
      "id == 1" = { string = { text = t; }; };
      "id == 2" = { string = { text = t; }; };
      "id == 3" = { string = { text = t; }; };
      "id == 4" = { string = { text = t; }; };
      "id == 5" = { string = { text = t; }; };
      "id == 6" = { string = { text = t; }; };
      "id == 7" = { string = { text = t; }; };
      "id == 8" = { string = { text = t; }; };
      "id == 9" = { string = { text = t; }; };
    };
  };
  riverTagOccupied = (mkRiverTag "");
  riverTagUnoccupied = (mkRiverTag "");
  riverTagOccupiedFocused = riverTagOccupied // {
    deco = { background = { color = colors.base01 + "ff"; }; };
  };
  riverTagUnoccupiedFocused = riverTagUnoccupied // {
    deco = { background = { color = colors.base01 + "ff"; }; };
  };
  riverTagUrgent = riverTagOccupied // {
    deco = { background = { color = colors.base09 + "ff"; }; };
  };
in {
  programs.yambar = {
    enable = true;
    settings = {
      bar = {
        height = 26;
        location = "top";
        spacing = 5;
        margin = 7;

        font = "Inconsolata Nerd Font:pixelsize=12";

        foreground = colors.base04 + "ff";
        background = colors.base00 + "ff";

        left = [
          {
            river = {
              content = [
                { map = {
                  on-click = {
                    left = "sh -c \"riverctl set-focused-tags $((1 << ({id} - 1)))\"";
                    right = "sh -c \"riverctl toggle-focused-tags $((1 << ({id} - 1)))\"";
                  };
                  conditions = {
                    "state == urgent" = {
                      map = riverTagUrgent;
                    };
                    "(state == focused || state == unfocused) && occupied" = {
                      map = riverTagOccupiedFocused;
                    };
                    "(state == focused || state == unfocused) && ~occupied" = {
                      map = riverTagUnoccupiedFocused;
                    };
                    "state == invisible && occupied" = {
                      map = riverTagOccupied;
                    };
                    "state == invisible && ~occupied" = {
                      map = riverTagUnoccupied;
                    };
                  };
                }; }
              ];
            };
          }
          {
            foreign-toplevel = {
              content = [
                { map = {
                  conditions = {
                    "~activated" = { empty = {}; };
                    "activated" = { string = { text = "{title}"; }; };
                  };
                }; }
              ];
            };
          }
        ];

        right = [
          {
            clock = {
              date-format = "%a %b %d";
              time-format = "%H:%M%p";
              content = [
                { string = { text = "{date} {time}"; }; }
              ];
            };
          }
        ];
      };
    };
  };
}

