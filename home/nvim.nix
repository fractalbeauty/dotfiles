{ inputs, lib, config, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      mouse = "a";

      # search
      hlsearch = true;
      incsearch = true;
      ignorecase = true;

      # indentation
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 0;
      autoindent = true;
    };

    keymaps = let
      normal =
        lib.mapAttrsToList
          (key: action: {
            mode = "n";
            inherit action key;
          })
        {
          # save with leader+w
          "<leader>w" = ":w<CR>";

          # save+make with leader+m
          "<leader>m" = ":w<CR>:!make<CR><CR>";

          # move line with alt+up/down
          "<M-Up>" = ":move -2<CR>";
          "<M-Down>" = ":move +1<CR>";
        };
      insert =
        lib.mapAttrsToList
          (key: action: {
            mode = "i";
            inherit action key;
          })
        {
          # move line with alt+up/down
          "<M-Up>" = "<ESC>:move -2<CR>==gi";
          "<M-Down>" = "<ESC>:move +1<CR>==gi";
        };
      visual =
        lib.mapAttrsToList
          (key: action: {
            mode = "v";
            inherit action key;
          })
        {
          # keep selection after indenting
          "<" = "<gv";
          ">" = ">gv";
          "<TAB>" = ">gv";
          "<S-TAB>" = "<gv";

          # move selection with alt+up/down
          "<M-Up>" = ":move '<-2<CR>gv=gv";
          "<M-Down>" = ":move '>+1<CR>gv=gv";
        };
    in
      config.nixvim.helpers.keymaps.mkKeymaps
        { options.silent = true; }
        (normal ++ insert ++ visual);

    autoCmd = [
      {
        event = [ "FileType" ];
        pattern = [ "nix" ];
        command = "setlocal shiftwidth=2 tabstop=2 expandtab";
      }
    ];
  };
}

