{pkgs, ...}:
with pkgs; let
  diffTools = [
    czkawka
    meld
  ];
  emulators = [
    pcsx2
  ];
  language = [
    goldendict-ng
  ];
  other = [
    # gnome.gnome-sound-recorder
    # citations
    audio-recorder
    helm
    raider
    nextjs-ollama-llm-ui
  ];
in {
  home.packages = diffTools ++ emulators ++ language ++ other;
}
