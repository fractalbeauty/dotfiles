{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ncdu
    hyfetch
    unstable.croc # v10
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
  };
}

