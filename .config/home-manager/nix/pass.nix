{
  pkgs,
  config,
  ...
}: {
  # Needed to work with pass.
  home.file.".local/share/gnupg/gpg-agent.conf".text = ''
    # ╔═════════════════════════ gpg-agent configuration ═════════════════════════╗
    # ║ Location: $GNUPGHOME/gpg-agent.conf or ~/.gnupg/gpg-agent.conf            ║
    # ║                                                                           ║
    # ║ Note:                                                                     ║
    # ║ After changing the configuration, reload the agent:                       ║
    # ║   $ gpg-connect-agent reloadagent /bye                                    ║
    # ╚═══════════════════════════════════════════════════════════════════════════╝
    grab
    pinentry-program ${pkgs.pinentry.${config.services.gpg-agent.pinentryFlavor}}/bin/pinentry
  '';

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gtk2";
  };

  home.packages = with pkgs; [
    wl-clipboard
    gnupg
    pass
  ];
}
