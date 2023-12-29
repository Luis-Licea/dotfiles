{pkgs, ...}:
with pkgs; let
  networkMetrics = [
    nethogs
    btop # htop/nmon replacement.
    iftop # Network monitoring.
    htop-vim
    # mtr # Network diagnostics tool.
    # iperf3
    # dnsutils # `dig` + `nslookup`
    # ldns # Replacement fo dig, provides the command `drill`.
    # aria2 # Multi-protocol & multi-source command-line download utility.
    # socat # openbsd-netcat replacement.
    # nmap # Newtork discovery and security auditing utility.
    # ipcalc # IPv4/IPv6 address calculator.
  ];
  systemMetrics = [
    neofetch
    hyperfine
    lm_sensors # `sensors` command.
  ];
  search = [
    ripgrep # Search files.
    fd
  ];
  utilities = [
    bashmount
    file
    lsof
    ddh
  ];
  bat-utils = with bat-extras; [
    batdiff
    batgrep
    batman
    batpipe
    batwatch
    prettybat
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
  other = [
    direnv
    yq-go # Yaml processor.
    fzf # Fuzzy finder.
    tealdeer

    gnome.gnome-disk-utility # Look into cfdisk parted
    frogmouth

    # hexyl
    # numbat
    # vivid
  ];
in {
  home.packages =
    networkMetrics
    ++ systemMetrics
    ++ search
    ++ utilities
    ++ fileManagers
    ++ versionControl
    ++ bat-utils
    ++ other;
}
