{ pkgs, ... }:

{
  # will be deprecated in a future release
  i18n.inputMethod ={
    enabled = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        fcitx5-mozc
      ];
    };
  };
}

