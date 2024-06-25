{ inputs, pkgs, ... }:

{
  imports = [
    ../river/river.nix
    ../foot.nix
    ../firefox.nix

    ../zsh.nix
    ../nvim.nix
    ../utils.nix
  ]; 

  stylix.enable = true;
  stylix.image = ../wallpapers/ZSC_0810.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
  stylix.fonts = {
    monospace = {
      package = pkgs.inconsolata;
      name = "Inconsolata";
    };
  };
  stylix.opacity = {
    terminal = 0.9;
  };

  fonts.fontconfig.defaultFonts = {
    monospace = [ "Inconsolata" ];
  };

  home.stateVersion = "24.05";
}

