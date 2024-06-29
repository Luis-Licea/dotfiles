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
    audio-recorder
    raider
    # gnome.gnome-sound-recorder
  ];
in {
  home.packages = emulators ++ diffTools ++ other;
}
