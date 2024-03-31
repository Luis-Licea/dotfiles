{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      asvetliakov.vscode-neovim
      streetsidesoftware.code-spell-checker
      # streetsidesoftware.code-spell-checker-spanish
    ];
  };
}
