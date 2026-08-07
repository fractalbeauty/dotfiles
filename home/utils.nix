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
    fzf
    ripgrep
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
      rebase.autostash = true;
    };
    
    ignores = [
      ".direnv/"
    ];
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "hazel";
        email = "hazel@meows.zip";
      };
      revsets = {
        bookmark-advance-to = "closest_pushable(@)";
      };
      revset-aliases = {
        "closest_pushable(to)" = "heads(::to & mutable() & ~description(exact:'') & (~empty() | merges()))";
      };
      aliases = {
        recent = [ "bookmark" "list" "--sort=committer-date-" "--color=always" ];
        bookmark-create-tracked = [
          "util" "exec" "--"
          "sh" "-c"
          "jj bookmark create \"$1\" -r 'closest_pushable(@)' && jj bookmark track \"$1\" --remote origin"
          "_"
        ];
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}

