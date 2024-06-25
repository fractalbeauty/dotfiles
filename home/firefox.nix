{ ... }:

{
  programs.firefox = {
    enable = true;

    policies = {
      DisablePocket = true;
    };

    profiles.main = {
      id = 0;
      name = "main";
      isDefault = true;

      # TODO: maybe not working?
      userChrome = ''
        #main-window:not([extradragspace="true"]) #TabsToolbar > .toolbar-items {
          opacity: 0;
          pointer-events: none;
        }
        #main-window #TabsToolbar {
          visibility: collapse !important;
        }
      '';
    };
  };
}

