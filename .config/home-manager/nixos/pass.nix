{
  config,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (
      final: prev: {
        pass = prev.pass.override {x11Support = false;};
      }
    )
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableBrowserSocket = true;
    enableExtraSocket = true;
  };

  environment = {
    # Needed to work with pass.
    etc."gnupg/gpg-agent.conf".text = ''
      # ╔═══════════════════════════════════════════════════════════════════════════╗
      # ║ gpg-agent configuration (~/.gnupg/gpg-agent.conf)                         ║
      # ║                                                                           ║
      # ║ Note:                                                                     ║
      # ║ After changing the configuration, reload the agent:                       ║
      # ║   $ gpg-connect-agent reloadagent /bye                                    ║
      # ╚═══════════════════════════════════════════════════════════════════════════╝
      pinentry-program ${pkgs.pinentry.${config.programs.gnupg.agent.pinentryFlavor}}/bin/pinentry
    '';

    sessionVariables = rec {
      XDG_DATA_HOME = "$HOME/.local/share";
      # [gnupg]: $HOME/.gnupg
      GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
      # [pass]: $HOME/.password-store
      PASSWORD_STORE_DIR = "${XDG_DATA_HOME}/pass";
    };
  };
}
