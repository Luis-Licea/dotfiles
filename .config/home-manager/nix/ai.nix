{pkgs, ...}:
with pkgs; let
  aiPackages = [
    nextjs-ollama-llm-ui
    aichat
    oterm
    # Untested
    # alpaca
    # gollama
    # lexido
    # opencommit
    # mods
    # yai
    # tabby
    # imaginer
    # upscayl
    # gptscript
    # code-cursor
    # chatd
    # rewind-ai
    # lsp-ai
    # rclip
    # fabric-ai
    # avante.nvim
    # sourcery
    # screenpipe
    # pleace-cli
    # lunacy
    # plandex
  ];
  # ytermusic pairdrop fim
in {
  home.packages = aiPackages;
}
