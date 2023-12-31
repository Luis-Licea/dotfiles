{
  pkgs,
  config,
  ...
}: {
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    package = pkgs.nixVersions.nix_2_17;
  };

  boot = {
    # Configure the /tmp folder.
    tmp = {
      # Make NixOS put /tmp on a tmpfs.
      useTmpfs = true;
      # The maximum amount of RAM /tmp is allowed to take.
      tmpfsSize = "%80";
    };
  };

  networking.extraHosts = ''
    # /etc/hosts - Block YouTube.
    127.0.0.1       www.youtube.com
    127.0.0.1       m.youtube.com
    127.0.0.1       youtube.com
    127.0.0.1       youtu.be
    127.0.0.1       ytimg.com
    127.0.0.1       l.google.com
    127.0.0.1       googlevideo.com
  '';

  # services.dbus.enable = true;

  ## Printers ##
  # Enable CUPS to print documents. Add printers on: http://localhost:631/admin
  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true; # For a WiFi printer.
    };
  };

  ## Sound ##
  # Enable sound with pipewire.
  security.rtkit.enable = true; # Optional but recommended.
  services.pipewire = {
    alsa.enable = true;
    enable = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  programs = {
    neovim = {
      enable = false;
      # Set EDITOR to nvim.
      defaultEditor = true;
    };

    zsh = {
      # Whether to configure zsh as an interactive shell.
      enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = ["vi-mode" "git"];
      };
    };

    bash.shellAliases = config.programs.zsh.shellAliases;
  };

  # Select internationalisation properties.
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  # Might need to `rfkill unblock bluetooth`.
  hardware.bluetooth.enable = true;

  # Install nerd fonts.
  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      (nerdfonts.override {fonts = ["Meslo" "FiraCode"];})
    ];
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      # Print valid font names:
      # find -L /run/current-system/sw/share/X11/fonts -type f -exec fc-query -f "%{family[0]}\n" {} \; | sort | uniq
      defaultFonts = {
        monospace = ["FiraCode Nerd Font Mono" "MesloLGS Nerd Font Mono" "Noto Sans Mono" "DejaVu Sans Mono"];
        serif = ["Noto Serif" "DejaVu Serif"];
        sansSerif = ["Noto Sans" "DejaVu Sans"];
      };
    };
  };

  environment = {
    # Enable users to log in with Bash and ZSh shells in GDM.
    shells = with pkgs; [bashInteractive zsh];

    # This is using a rec (recursive) expression to set and access XDG_BIN_HOME within the expression
    # For more on rec expressions see https://nix.dev/tutorials/first-steps/nix-language#recursive-attribute-set-rec
    # Equivalent to `/etc/profile`.
    sessionVariables = rec {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      # Not officially in the specification
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [
        "${XDG_BIN_HOME}"
        "${XDG_BIN_HOME}/scripts"
      ];

      # Custom variables.
      NIXCONFIG = "/etc/nixos/configuration.nix";

      # XDG-Ninja

      # [cargo]: $HOME/.cargo
      CARGO_HOME = "${XDG_DATA_HOME}/cargo";

      # [gnupg]: $HOME/.gnupg
      GNUPGHOME = "${XDG_DATA_HOME}/gnupg";

      # [pass]: $HOME/.password-store
      PASSWORD_STORE_DIR = "${XDG_DATA_HOME}/pass";

      # [zsh]: $HOME.zshrc
      ZDOTDIR = "${XDG_CONFIG_HOME}/zsh";
    };

    # Equivalent to `/etc/environment`.
    variables = {
      # Use Fcitx or Fcitx5 for input method control.
      # GTK_IM_MODULE = "fcitx";
      # QT_IM_MODULE = "fcitx";
      # SDL_IM_MODULE = "fcitx";
      # XMODIFIERS = "@im=fcitx";

      # Allow fcitx5 to change keyboard layout in alacritty.
      WINIT_UNIX_BACKEND = "x11";

      # Change log file path.
      NVIM_LOG_FILE = "/tmp/nvim/log";

      # Disallow shell commands.
      LESSSECURE = "1";
    };

    # Configure how NTFS removable disks should be mounted.
    etc."udisks2/mount_options.conf".text = ''
      [defaults]
      ntfs_defaults=uid=$UID,gid=$GID,prealloc
    '';
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;

  # Whether to generate the manual page index caches. This allows searching for
  # a page or keyword using utilities like apropos(1) and the -k option of
  # man(1).
  documentation.man.generateCaches = true;

  # This option defines the default shell assigned to user accounts. This can
  # be either a full system path or a shell package. This must not be a store
  # path, since the path is used outside the store (in particular in
  # /etc/passwd).
  users.defaultUserShell = pkgs.zsh;
}
