{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    # ./8bitdo.nix
    # ./dwl.nix
    # ./gnome.nix
    ./ai.nix
    ./hyprland.nix
    ./ntfs.nix
    ./nvim.nix
    ./shell.nix
    # ./gpu.nix
  ];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      use-xdg-base-directories = true;
    };
    package = pkgs.nixVersions.nix_2_19;
  };

  # Configure the /tmp folder.
  boot.tmp = {
    # Make NixOS put /tmp on a tmpfs.
    useTmpfs = true;
    # The maximum amount of RAM /tmp is allowed to take.
    tmpfsSize = "%80";
  };

  # Might need to `rfkill unblock bluetooth`.
  hardware = {
    # Enable proprietary blobs to avoid choppy Bluetooth.
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      # Enable support for the PS3 DualShock 3.
      input.General = {
        ClassicBondedOnly = false;
      };
    };
  };

  environment = {
    # Equivalent to `/etc/profile`.
    sessionVariables = rec {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_PICTURES_DIR = "$HOME/Pictures";

      # Not officially in the specification
      XDG_BIN_HOME = "$HOME/.local/bin";
      PATH = [
        "${XDG_BIN_HOME}"
        "${XDG_BIN_HOME}/scripts"
      ];

      # XDG-Ninja
      CARGO_HOME = "${XDG_DATA_HOME}/cargo"; # [cargo]: $HOME/.cargo
      GNUPGHOME = "${XDG_DATA_HOME}/gnupg"; # [gnupg]: $HOME/.gnupg
      KERAS_HOME = "${XDG_STATE_HOME}/keras"; # [python-tensorflow]: $HOME/.keras
      NODE_REPL_HISTORY = "${XDG_DATA_HOME}/node_repl_history"; # [nodejs]: $HOME/.node_repl_history
      PASSWORD_STORE_DIR = "${XDG_DATA_HOME}/pass"; # [pass]: $HOME/.password-store
      PYTHONSTARTUP = "$HOME/python/pythonrc"; # [python]: $HOME/.python_history
      RUSTUP_HOME = "${XDG_DATA_HOME}/rustup"; # [rustup]: $HOME/.rustup
      W3M_DIR = "${XDG_CONFIG_HOME}/w3m"; # [w3m]: $HOME/.w3m
      ZDOTDIR = "${XDG_CONFIG_HOME}/zsh"; # [zsh]: $HOME.zshrc
    };

    # Equivalent to `/etc/environment`.
    variables = {
      # Change log file path.
      NVIM_LOG_FILE = "/tmp/nvim/log";

      # Disallow shell commands in less.
      LESSSECURE = "1";
    };

    systemPackages = with pkgs; [
      alacritty # Essential.
      gnome.simple-scan # HM version does not work correctly.
      home-manager
      localsend # HM version does not work correctly.
      mpv # HM version does not work correctly.
      obs-studio
      paperwork # HM version is a few minor versions behind.
      cached-nix-shell
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  # Open ports in the firewall.
  # localsend needs port 53317 to receive files.
  networking.firewall.allowedTCPPorts = lib.optional (builtins.elem pkgs.localsend config.environment.systemPackages) 53317;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;

  # Whether to generate the manual page index caches. This allows searching for
  # a page or keyword using utilities like apropos(1) and the -k option of
  # man(1).
  documentation.man.generateCaches = true;
}
