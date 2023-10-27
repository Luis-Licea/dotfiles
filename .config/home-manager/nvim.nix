{ pkgs, lib, config, options, specialArgs, modulesPath }: {
  # with pkgs;

  home.packages = with pkgs; [

    ruff

    shellcheck # Bash linter.
    shellharden # Bash Formatter, Linter
    shfmt # Bash Formatter, Linter

    marksman # Language server.

    stylua # Language server.
    jdk17 # Needed by ltex-ls.

    nixfmt # Nix formatter.
    statix # Nix diagnostics.
  ];

  programs.neovim = {
    enable = true;
    # Install the latest version of Neovim
    package = pkgs.neovim-unwrapped;

    withNodeJs = true;

    # Install additional Nix packages alongside Neovim
    plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
    extraPackages = with pkgs; [
      # Install the vim-tree-lua plugin
      # vimPlugins.vim-tree-lua
      lua-language-server

      nil # Nix language server.
      rnix-lsp # Nix language server.
      nixd

      # Install the vim-airline plugin
      # vimPlugins.vim-airline
    ];
  };
}
