{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./block-youtube.nix
    ./fonts.nix
    ./printer.nix
    ./virtualization.nix
  ];
  hardware.pulseaudio.enable = false;

  environment.gnome.excludePackages =
    (with pkgs.gnome; [
      baobab # disk usage analyzer
      cheese # photo booth
      eog # image viewer
      epiphany # web browser
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
      gnome-screenshot
      gnome-system-monitor
      gnome-weather
      gnome-disk-utility
    ])
    ++ (with pkgs; [
      gnome-photos
      gnome-connections
      gedit # text editor
    ]);

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  services = {
    # Enable automatic login for the user.
    displayManager.autoLogin = {
      enable = true;
      user = "luis";
    };

    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # Enable the GNOME Display Manager.
      displayManager.gdm.enable = true;
      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = true;

      ## Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator # Systray icons.
    gnomeExtensions.forge # Tiling window manager.
    gnome.dconf-editor # View dconf settings.
  ];

  # Enable Systray icons.
  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];
}
