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
    chezmoi
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
