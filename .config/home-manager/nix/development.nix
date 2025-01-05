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
      # gnome-builder
      dart
      deno
      nodejs_22
      python3
      tinycc
    ]
    ++ rust;
}
