{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    # ./8bitdo.nix
    # ./dwl.nix
    # ./gnome.nix
    # ./gpu.nix
    # ./synology.nix
    # ./ai.nix
    # ./game.nix
    ./hyprland.nix
    ./nvim.nix
    ./shell.nix
    ./pager.nix
    # ./wine.nix
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
    };
    # package = pkgs.nixVersions.nix_2_19;
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

      # TUI file manager
      #yazi
      #yaziPlugins.git

      # Music
      eartag
      media-downloader # Yt-dlp front-end
      lollypop # Music player
      beets # Musig organizer
      lrcget # Synced lyrics downloader

      # Version control
      git
      git-lfs
      gitui

      # Text editor
      helix

      # Formatter for Markdown
      prettier

      # LSPs and formatters for coding
      # Markdown LSP
      marksman
      # Lua
      stylua # Formatter
      lua-language-server # LSP
      # Bash
      shellcheck # Bash linter.
      shellharden # Bash linter, formatter.
      shfmt # Bash formatter.
      bash-language-server # Bash language server.
      # Nix
      nil # Nix language server.
      nixd # Nix language server.

      # Unified shell theme
      starship

      # Needeb by yazi
      ueberzugpp

      brave # Essential.
      cached-nix-shell
      home-manager
      mpv # HM version does not work correctly.
      obs-studio
      paperwork # HM version is a few minor versions behind.
      simple-scan # HM version does not work correctly.
      ungoogled-chromium # Used for isolation.
    ];
  };

  programs.yazi = {
    enable = true;
    plugins = {
      git = pkgs.yaziPlugins.git;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disable annoying prompt to enter credentials when opening Thunar or Brave.
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  system = {
    # Automate updating nixos channel.
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true; # Reboots if kernel changes

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    copySystemConfiguration = false;
  };

  # Whether to generate the manual page index caches. This allows searching for
  # a page or keyword using utilities like apropos(1) and the -k option of
  # man(1).
  documentation.man.cache.enable = true;
}
