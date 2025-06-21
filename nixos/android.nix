{ pkgs, ... }:

{
  # android studio
  environment.systemPackages = [ pkgs.android-studio ];

  # adb
  programs.adb.enable = true;
  users.users.hazel.extraGroups = ["adbusers"];
}

