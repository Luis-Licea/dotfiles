{ pkgs, ... }: {

  # Codestral Mamba 7B
  # Qwen 3.5 4B
  services = {
    ollama = {
      enable = true;
      package = pkgs.ollama-vulkan; # ROCm is not supported.
    };
  };

  # aider --model ollama_chat/mistral
  environment.systemPackages = [
    pkgs.aider-chat
  ];
}
