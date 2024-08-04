{pkgs, ...}:
with pkgs; let
  bat-utils = with bat-extras; [
    bat
    batdiff
    batgrep
    batman
    batpipe
    batwatch
    prettybat
  ];
  networkMetrics = [
    # aria2 # Multi-protocol & multi-source command-line download utility.
    # dnsutils # `dig` + `nslookup`
    # ipcalc # IPv4/IPv6 address calculator.
    # iperf3
    # ldns # Replacement fo dig, provides the command `drill`.
    # mtr # Network diagnostics tool.
    # nmap # Newtork discovery and security auditing utility.
    # socat # openbsd-netcat replacement.
    btop # htop/nmon replacement.
    dig
    htop-vim
    iftop # Network monitoring.
    nethogs
    termshark
  ];
  systemMetrics = [
    amdgpu_top
    hyperfine
    lm_sensors # `sensors` command.
    neofetch
  ];
  search = [
    fd
    fzf # Fuzzy finder.
    ripgrep # Search files.
  ];
  utilities = [
    bashmount
    ddh
    file
    lsof
    sshfs
    xdg-utils
    xdotool
  ];
  fileManagers = [
    ranger
    xdragon
    joshuto
  ];
  versionControl = [
    git-lfs
    git
    gitui
  ];
  viewers = [
    glow # Needed by Neovim Telescope for Markdown file previews.
    nvimpager
  ];
  other = [
    bluetuith
    #keychain
    chezmoi
    #scc
    # podman
    # distrobox

    asciinema
    direnv
    yq-go # Yaml processor.
    tealdeer

    gnome.gnome-disk-utility # Look into cfdisk parted
    # frogmouth

    # hexyl
    # numbat
    # vivid
  ];
in {
  home.packages =
    bat-utils
    ++ networkMetrics
    ++ systemMetrics
    ++ search
    ++ utilities
    ++ fileManagers
    ++ versionControl
    ++ viewers
    ++ other;
}
