{ inputs, pkgs, ... }:

{
  imports = [
    ../../home/river/river.nix
    ../../home/yambar.nix
    ../../home/foot.nix
    ../../home/firefox.nix
    ../../home/vscode.nix
    ../../home/senpai.nix

    ../../home/scripts/scripts.nix

    ../../home/zsh.nix
    ../../home/nvim.nix
    ../../home/utils.nix
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
  stylix.image = ../../home/wallpapers/purple.png;
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

  stylix.targets.firefox.profileNames = [ "main" ];

  fonts.fontconfig.defaultFonts = {
    monospace = [ "Inconsolata Nerd Font" ];
    sansSerif = [ "Noto Sans" ];
    serif = [ "Noto Serif" ];
  };

  home.stateVersion = "24.05";
}
