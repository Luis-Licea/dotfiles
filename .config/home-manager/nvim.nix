{
  pkgs,
  lib,
  config,
  options,
  specialArgs,
  modulesPath,
}: {
  # with pkgs;

  home.packages = with pkgs; [
    black # Python formatter.
    isort # Python formatter.
    jq # JSON formatter.
    ruff # Python linter.
    shellcheck # Bash linter.
    shellharden # Bash linter, formatter.
    shfmt # Bash formatter.
    stylua # Lua formatter.


    marksman # Markdown language server; Provides TOC code action, and help with Markdown links, and references, not spelling.


    jdk17 # Needed by ltex-ls.

    alejandra # Nix formatter.
    statix # Nix diagnostics.
  ];

  programs.neovim = {
    enable = true;
    # Install the latest version of Neovim
    package = pkgs.neovim-unwrapped;

    withNodeJs = true;

    # Install additional Nix packages alongside Neovim
    plugins = [pkgs.vimPlugins.nvim-treesitter.withAllGrammars];
    extraPackages = with pkgs; [
      # Install the vim-tree-lua plugin
      # vimPlugins.vim-tree-lua
      lua-language-server

      nil # Nix language server.
      nixd # Nix language server.

      # Install the vim-airline plugin
      # vimPlugins.vim-airline
    ];
  };
}
