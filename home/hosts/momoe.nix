{ inputs, pkgs, ... }:

{
  imports = [
    ../river/river.nix
    ../yambar.nix
    ../foot.nix
    ../firefox.nix
    ../vscode.nix
    ../senpai.nix

    ../scripts/scripts.nix

    ../zsh.nix
    ../nvim.nix
    ../utils.nix
  ];

  home.packages = with pkgs; [
    # fonts
    noto-fonts
    noto-fonts-cjk-sans
    nerd-fonts.inconsolata

    # apps
    nomachine-client
    signal-desktop
    anki-bin
    obsidian
    qbittorrent
    mpv
    google-chrome

    # games
    lutris
  ];

  programs.zathura.enable = true;

  services.wpaperd.enable = true;

  stylix.enable = true;
  stylix.image = ../wallpapers/purple.png;
  stylix.polarity = "dark";
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-forest-light.yaml";
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.inconsolata;
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
