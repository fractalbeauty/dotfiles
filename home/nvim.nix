{ pkgs, inputs, lib, config, ... }:

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

    plugins = {
      treesitter = {
        enable = true;
      };

      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          sources = [
            { name = "luasnip"; }
            { name = "nvim_lsp"; }
          ];
          snippet = { 
            expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
          };
          mapping = {
            "<Tab>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require('luasnip')
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.locally_jumpable(1) then
                  luasnip.jump(1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                local luasnip = require('luasnip')
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
        };
      };
      #cmp-nvim-lsp = {
      #  enable = true;
      #};
      cmp_luasnip = {
        enable = true;
      };

      luasnip = {
        enable = true;
        fromVscode = [
          { paths = ../snippets; }
        ];
      };
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
      config.lib.nixvim.keymaps.mkKeymaps
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
