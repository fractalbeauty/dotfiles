{ pkgs, inputs, ... }:

let
  exts = inputs.nix-vscode-extensions.extensions.${pkgs.system};
in {
  programs.vscode = {
    enable = true;

    extensions = [
      exts.vscode-marketplace.mkhl.direnv
      exts.vscode-marketplace.sainnhe.everforest
      exts.vscode-marketplace.esbenp.prettier-vscode
      exts.vscode-marketplace.rust-lang.rust-analyzer
    ];

    userSettings = {
       "workbench.colorTheme" = "Everforest Dark";
      "[javascript][typescript][javascriptreact][typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnSave" = true;
      };
      "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        "editor.formatOnSave" = true;
      };
    };
  };
}

