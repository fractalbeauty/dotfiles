{ pkgs, inputs, lib, config, ... }:

{
  programs.senpai = {
    enable = true;
    config = {
      address = "irc+insecure://soju:6667"; # via tailscale
      nickname = "hazel";
      password-cmd = ["cat" "/home/hazel/.sojupass"]; # meh
    };
  };
}
