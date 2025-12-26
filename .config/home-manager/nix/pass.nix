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
    pinentry-program ${config.services.gpg-agent.pinentryPackage}/bin/pinentry
  '';

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  home.packages = with pkgs; [
    gcr # Needed for Gnome pin-entry.
    gnupg
    keepassxc
    pass
    wl-clipboard
  ];
}
