{pkgs, ...}:
with pkgs; let
  rust = [
    cargo
    rustc
    gcc
  ];
in {
  home.packages =
    [
      python3
      nodejs_22
      tinycc
    ]
    ++ rust;
}
