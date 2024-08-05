{ inputs, pkgs, ... }:

{
  imports = [
    ../river/river.nix
    ../yambar.nix
    ../foot.nix
    ../firefox.nix
    ../vscode.nix

    ../scripts/scripts.nix

    ../zsh.nix
    ../nvim.nix
    ../utils.nix
  ];

  home.packages = with pkgs; [
    #inconsolata
    inconsolata-nerdfont
  ];

  stylix.enable = true;
  stylix.image = ../wallpapers/riverside.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
  stylix.fonts = {
    monospace = {
      package = pkgs.inconsolata-nerdfont;
      name = "Inconsolata Nerd Font";
    };
  };
  stylix.opacity = {
    terminal = 0.9;
  };
  stylix.targets.vscode.enable = false;

  fonts.fontconfig.defaultFonts = {
    monospace = [ "Inconsolata Nerd Font" ];
  };

  home.stateVersion = "24.05";
}

