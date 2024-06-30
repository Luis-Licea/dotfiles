{pkgs, ...}: let
  pythonPackages = with pkgs; [
    black # Python formatter.
    isort # Python formatter.
    nodePackages.pyright # Python diagnostics.
    pylint # Python linter.
    python311Packages.debugpy # Python debugger.
    python312Packages.flake8 # Python linter.
    ruff # Python linter.
  ];
  bashPackages = with pkgs; [
    shellcheck # Bash linter.
    shellharden # Bash linter, formatter.
    shfmt # Bash formatter.
    nodePackages.bash-language-server # Bash language server.
  ];
  nixPackages = with pkgs; [
    alejandra # Nix formatter.
    statix # Nix diagnostics.
    nixfmt-rfc-style # Nix formatter.
  ];
  cppPackages = with pkgs; [
    # clangd = 'clangd', # C/C++
    ccls # C/C++ language server.
    neocmakelsp
  ];
  webDevPackages = [
    # cssls # CSS language server.
  ];
  other = with pkgs; [
    # 'checkstyle', # Java linter.
    # 'cmakelang', # CMake linter.
    # 'google-java-format', # Java formatter.
    jq # JSON formatter.
    # 'prettier', # Markdown formatter.
    stylua # Lua formatter.
    jsonnet # Functional language similar to Nix.
    perlnavigator # Perl linter.

    # # Debug adapters.
    # 'bash-debug-adpater', # Bash, Sh.
    # 'cpptools', # C++, C, Rust.
    # 'js-debug-adapter', # JavaScript, TypeScript.

    # 'java-test' # Java?
    # awk_ls = 'awk-language-server', # AWK
    # dockerls = 'dockerls', # Docker
    # groovyls = 'groovyls', # Groovy
    # java_debug_adapter = # 'java-debug-adapter' # Java?
    # java_language_server = 'java-language-server' # Java
    # jdtls = 'jdtls', # Java
    # neocmake = 'neocmakelsp', # CMake
    # phpactor = 'phpactor', # PHP
    # sqls = 'sqls', # SQL
    #
    # eslint = 'eslint', # JavaScript, TypeScript; Linter needs .eslintrc.yml.
    # html = 'html', # HTML
    # jsonls = 'jsonls', # JSON
    # ltex = 'ltex-ls', # Tex and Markdown spell checking.
    # lua_ls = 'lua-language-server', # Lua
    marksman # Markdown language server; Provides TOC code action, and help with Markdown links, and references, not spelling.

    # rust-analyzer # Rust linter.
    # taplo = 'taplo', # TOML
    # texlab = 'texlab', # LaTeX
    # tsserver = 'tsserver', # JavaScript, TypeScript; LSP functionality.
    # typst_lsp = 'typst_lsp', # Typst
    # yamlls = 'yaml-language-server', # YAML

    jdk17 # Needed by ltex-ls.
  ];
in {
  home.packages =
    other
    ++ pythonPackages
    ++ bashPackages
    ++ nixPackages
    ++ cppPackages
    ++ webDevPackages;

  programs.neovim = {
    enable = true;
    # Install the latest version of Neovim
    package = pkgs.neovim-unwrapped;

    withNodeJs = true;

    # Install additional Nix packages alongside Neovim
    plugins = [
      # pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
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
