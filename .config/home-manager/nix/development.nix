{ pkgs, ... }: {
  home.packages = with pkgs; [
    # gcc
    # rustup
    nodejs
    python3
  ];
}
