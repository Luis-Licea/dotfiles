{pkgs, ...}:
with pkgs; let
  emulators = [
    pcsx2
  ];
  diffTools = [
    czkawka
    meld
  ];
  other = [
    firefox
  ];
in {
  home.packages = emulators ++ diffTools ++ other;
}
