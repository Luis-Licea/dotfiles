{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./block-youtube.nix
    ./fonts.nix
    ./ntfs.nix
    ./printer.nix
    ./virtualization.nix
  ];

  programs = {
    geary.enable = true;
    hyprland.enable = true;
    hyprlock.enable = true;
  };
  services.hypridle.enable = true;

  environment = {
    systemPackages = with pkgs; [
      adwaita-icon-theme # Fix missing icons.
      baobab # disk usage analyzer
      dunst # Notification server.
      gnome-calendar
      gnome-clocks
      gnome-disk-utility
      gnome-maps
      gnome-system-monitor
      hyprshot # Screenshot utility.
      libnotify # Notification commands.
      pwvucontrol # Volume control.
      rofi-wayland-unwrapped
      waybar
      wdisplays # tool to configure displays
      wlogout # Logout menu.
      wofi
      xdg-utils # for opening default programs when clicking links
      xfce.thunar # dolphin installs the fucking annoying, intrusive kwallet
    ];
    etc."greetd/environments".text = ''
      Hyprland
    '';
  };

  services.greetd = rec {
    enable = true;
    settings = {
      # Automatic login.
      initial_session = {
        command = "Hyprland";
        user = "luis";
      };
      default_session = settings.initial_session;
    };
  };
}
