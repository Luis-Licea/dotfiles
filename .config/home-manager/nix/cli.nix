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
  # browsers = [
  #   chawan
  #   lynx
  #   w3m
  # ];
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
    nethogs # A net top tool which displays traffic used per process instead of per IP or interface.
    termshark
  ];
  systemMetrics = [
    amdgpu_top
    hyperfine
    lm_sensors # `sensors` command.
    fastfetch
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
    # joshuto
  ];
  versionControl = [
    git
    git-lfs
    gitui
    # restic
  ];
  viewers = [
    glow # Needed by Neovim Telescope for Markdown file previews.
    nvimpager
  ];
  other = [
    bluetuith
    # keychain # A front-end to ssh-agent, allowing one long-running ssh-agent process per system, rather than per login
    # chezmoi
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
    ffmpeg-full
    # vivid
  ];
in {
  home.packages =
    bat-utils
    # ++ browsers
    ++ networkMetrics
    ++ systemMetrics
    ++ search
    ++ utilities
    ++ fileManagers
    ++ versionControl
    ++ viewers
    ++ other;
}
