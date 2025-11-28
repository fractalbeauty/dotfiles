{ pkgs, ... }:

{
  # android studio
  environment.systemPackages = [ pkgs.android-studio ];

  # adb
  programs.adb.enable = true;
}

