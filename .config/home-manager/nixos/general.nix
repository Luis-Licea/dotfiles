{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    # ./8bitdo.nix
    # ./gnome.nix
    ./dwl.nix
    ./fonts.nix
    ./hyprland.nix
    ./i18n.nix
    ./nvim.nix
    ./printer.nix
    ./shell.nix
    ./virtualization.nix
  ];

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    package = pkgs.nixVersions.nix_2_19;
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

  # Might need to `rfkill unblock bluetooth`.
  hardware.bluetooth.enable = true;

  environment = {
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
      # Change log file path.
      NVIM_LOG_FILE = "/tmp/nvim/log";

      # Disallow shell commands in less.
      LESSSECURE = "1";
    };

    # Configure how NTFS removable disks should be mounted.
    etc."udisks2/mount_options.conf".text = ''
      [defaults]
      ntfs_defaults=uid=$UID,gid=$GID,prealloc
    '';
    systemPackages = with pkgs; [
      alacritty # Essential.
      home-manager
      localsend # HM version does not work correctly.
      mpv # HM version does not work correctly.
      obs-studio
      ollama
      paperwork # HM version is a few minor versions behind.
      gnome.simple-scan # HM version does not work correctly.
    ];
  };

  # Open ports in the firewall.
  # localsend needs port 53317 to receive files.
  networking.firewall.allowedTCPPorts = lib.optional (builtins.elem "localsend" config.environment.systemPackages) 53317;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;

  # Whether to generate the manual page index caches. This allows searching for
  # a page or keyword using utilities like apropos(1) and the -k option of
  # man(1).
  documentation.man.generateCaches = true;
}
