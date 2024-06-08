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
    #citations
    raider
  ];
in {
  home.packages = emulators ++ diffTools ++ other;
}
