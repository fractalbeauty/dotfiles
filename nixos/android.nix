{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.android-studio pkgs.android-tools ];
}

