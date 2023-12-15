{pkgs, ...}:
with pkgs; let
  emulators = [
    pcsx2
  ];
  diffTools = [
    meld
  ];
in {
  home.packages = emulators ++ diffTools;
}
