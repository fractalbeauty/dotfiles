{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.services.lemurs;
  ttyString = "tty${toString cfg.tty}";
  settingsFormat = pkgs.formats.toml { };
  settingsFile = settingsFormat.generate "config.toml" cfg.settings;
in
{
  options.services.lemurs = {
    enable = mkEnableOption "Whether to enable Lemurs.";

    package = mkPackageOption pkgs "lemurs" { };

    settings = mkOption {
      type = settingsFormat.type;
      description = ''
        Lemurs configuration ([documentation](https://github.com/coastalwhite/lemurs/blob/main/extra/config.toml)).
      '';
    };

    tty = mkOption {
      type = types.int;
      default = 1;
      description = ''
        The tty that Lemurs should use. This option also disables getty on that tty.
      '';
    };

    river.enable = mkEnableOption "Whether to enable River as an environment.";
  };

  config = mkIf cfg.enable {
    services.lemurs.settings.tty = mkDefault cfg.tty;

    security.pam.services.lemurs = {
      allowNullPassword = true;
      startSession = true;
      setLoginUid = false;
      enableGnomeKeyring = mkDefault config.services.gnome.gnome-keyring.enable;
#      text = ''
        #%PAM-1.0
#        auth        include    login
#        account     include    login
#        session     include    login
#        password    include    login
#      '';
    };

    # TODO
    # This prevents nixos-rebuild from killing greetd by activating getty again
    # systemd.services."autovt@${tty}".enable = false;

    services.displayManager.enable = lib.mkDefault true;

    systemd.services.lemurs = {
      aliases = [ "display-manager.service" ];

      unitConfig = {
        Description = "Lemurs";
        After = [
          "systemd-user-sessions.service plymouth-quit-wait.service"
          "getty@${ttyString}.service"
        ]; 
        Conflicts = [
          "getty@${ttyString}.service"
        ];
      };

      serviceConfig = {
        ExecStart = "${pkgs.lemurs}/bin/lemurs --config ${settingsFile}";
        StandardInput = "tty";
        TTYPath = "/dev/${ttyString}";
        TTYReset = "yes";
        TTYVHangup = "yes";
        Type = "idle";
      };

      # Don't kill a user session when using nixos-rebuild
      restartIfChanged = false;

      #wantedBy = [ "graphical.target" ];
    };

    #systemd.defaultUnit = "graphical.target";

    # Create directories potentially required by supported greeters
    # See https://github.com/NixOS/nixpkgs/issues/248323
    #systemd.tmpfiles.rules = [
    #  "d '/var/cache/tuigreet' - greeter greeter - -"
    #];

    environment.etc."lemurs/wayland/river" = {
      source = pkgs.writeShellScript "river" "exec ${pkgs.river}/bin/river";
      enable = cfg.river.enable;
    };
  };
}
