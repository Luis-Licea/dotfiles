{pkgs, ...}:
with pkgs; let
  rust = [
    # cargo
    # rustc
    gcc
    rustup
  ];
in {
  home.packages =
    [
      python3
      nodejs_22
      deno
      tinycc
      # gnome-builder
    ]
    ++ rust;
}
