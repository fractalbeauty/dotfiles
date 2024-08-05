{ ... }:

{
  programs.firefox = {
    enable = true;

    policies = {
      DisablePocket = true;

      Preferences = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = { Value = true; Status = "locked"; };
      };
    };

    profiles.main = {
      id = 0;
      name = "main";
      isDefault = true;

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

