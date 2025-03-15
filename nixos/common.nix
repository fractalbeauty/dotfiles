{ pkgs, ... }:

{
  time.timeZone = "America/Los_Angeles";

  # tools
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
  ];

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}

