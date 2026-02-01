{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ncdu
    hyfetch
    btop
    croc
    ngrok
    file
    tree
    flyctl
    powertop
    unzip
    tokei
    dig
    nh
    nixfmt
    rclone
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    
    settings = {
      user = {
        name = "hazel";
        email = "hazel@meows.zip";
      };
      init.defaultbranch = "main";
      pull.rebase = true;
      push.autosetupremote = true;
    };
    
    ignores = [
      ".direnv/"
    ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}

