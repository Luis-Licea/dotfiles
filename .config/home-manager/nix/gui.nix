{pkgs, ...}:
with pkgs; let
  emulators = [
    pcsx2
  ];
  diffTools = [
    czkawka
    meld
  ];
in {
  home.packages = emulators ++ diffTools;
}
