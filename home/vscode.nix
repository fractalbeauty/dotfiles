{ pkgs, inputs, lib, config, ... }:

let
  exts = inputs.nix-vscode-extensions.extensions.${pkgs.system};

  # TODO: this seems kinda brittle
  vscodeCfg = config.programs.vscode;
  vscodePname = vscodeCfg.package.pname;
  configDir = {
    "vscode" = "Code";
    "vscode-insiders" = "Code - Insiders";
    "vscodium" = "VSCodium";
    "openvscode-server" = "OpenVSCode Server";
  }.${vscodePname};
  userDir = "${config.xdg.configHome}/${configDir}/User";
  snippetDir = "${userDir}/snippets";

  snippetFiles = builtins.filter (f: f != "package.json") (
    builtins.attrNames (builtins.readDir ../snippets)
  );
in {
  programs.vscode = {
    enable = true;

    extensions = [
      exts.vscode-marketplace.mkhl.direnv
      exts.vscode-marketplace.sainnhe.everforest
      exts.vscode-marketplace.esbenp.prettier-vscode
      exts.vscode-marketplace.rust-lang.rust-analyzer
      exts.vscode-marketplace.tamasfe.even-better-toml
    ];

    userSettings = {
       "workbench.colorTheme" = "Everforest Dark";
      "[javascript][typescript][javascriptreact][typescriptreact][json][jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnSave" = true;
      };
      "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "editor.formatOnSave" = true;
      };
      "search.exclude" = {
        "**/.direnv/**" = true;
      };
    };
  };

  home.file = lib.mkMerge [
    (builtins.listToAttrs (
      map (f: {
        name = "${snippetDir}/${f}";
        value = {
          source = ../snippets/${f};
        };
      }) snippetFiles
    ))
  ];
}
