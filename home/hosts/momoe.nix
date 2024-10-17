{ inputs, pkgs, ... }:

let
  nerdfonts-pkg = (pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; });
in
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
    # fonts
    noto-fonts
    noto-fonts-cjk-sans
    nerdfonts-pkg

    # nomachine
    nomachine-client

    # apps
    anki-bin
    obsidian

    # games
    lutris
  ];

  stylix.enable = true;
  stylix.image = ../wallpapers/riverside2.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
  stylix.fonts = {
    monospace = {
      package = nerdfonts-pkg;
      name = "Inconsolata Nerd Font";
    };
    sansSerif = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
    };
    serif = {
      package = pkgs.noto-fonts;
      name = "Noto Serif";
    };
  };
  stylix.opacity = {
    terminal = 0.9;
  };
  stylix.targets.vscode.enable = false;

  fonts.fontconfig.defaultFonts = {
    monospace = [ "Inconsolata Nerd Font" ];
    sansSerif = [ "Noto Sans" ];
    serif = [ "Noto Serif" ];
  };

  home.stateVersion = "24.05";
}

