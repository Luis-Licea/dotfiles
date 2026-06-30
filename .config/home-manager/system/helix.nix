{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    helix

    # Formatter for Markdown
    prettier

    # LSPs and formatters for coding
    # Markdown LSP
    marksman
    # Lua
    stylua # Formatter
    lua-language-server # LSP
    # Bash
    shellcheck # Bash linter.
    shellharden # Bash linter, formatter.
    shfmt # Bash formatter.
    bash-language-server # Bash language server.
    # Nix
    nil # Nix language server.
    nixd # Nix language server.
  ];

  environment.variables.EDITOR = "hx";
}
