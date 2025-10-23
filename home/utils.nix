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
    nixfmt-rfc-style
    rclone
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    
    userName = "hazel";
    userEmail = "hazel@meows.zip";
    
    extraConfig = {
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

