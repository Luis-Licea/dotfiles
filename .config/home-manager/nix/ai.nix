{pkgs, ...}:
with pkgs; let
  other = [
    nextjs-ollama-llm-ui
  ];
in {
  home.packages = other;
}
