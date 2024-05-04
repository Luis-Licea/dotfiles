{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      # ms-python.debugpy
      # rvest.vs-code-prettier-eslint
      # streetsidesoftware.code-spell-checker-spanish
      # surv.typst-math
      alefragnani.project-manager
      asvetliakov.vscode-neovim
      eamodio.gitlens
      kamadorueda.alejandra
      mhutchie.git-graph
      nvarner.typst-lsp
      redhat.vscode-yaml
      streetsidesoftware.code-spell-checker
      tamasfe.even-better-toml
      tomoki1207.pdf
    ];
  };
}
