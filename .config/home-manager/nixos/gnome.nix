{pkgs, ...}: {
  environment.gnome.excludePackages = with pkgs.gnome; [
    baobab # disk usage analyzer
    cheese # photo booth
    eog # image viewer
    epiphany # web browser
    gedit # text editor
    simple-scan # document scanner
    totem # video player
    yelp # help viewer
    evince # document viewer
    file-roller # archive manager
    geary # email client
    seahorse # password manager

    # these should be self explanatory
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-screenshot
    gnome-system-monitor
    gnome-weather
    gnome-disk-utility
    pkgs.gnome-connections
  ];

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = false;

      displayManager = {
        # Enable the GNOME Display Manager.
        gdm.enable = true;

        # Enable automatic login for the user.
        autoLogin.enable = true;
        autoLogin.user = "luis";
      };
      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = true;

      ## Configure keymap in X11
      layout = "us";
      xkbVariant = "";

      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;
    };
  };
}
