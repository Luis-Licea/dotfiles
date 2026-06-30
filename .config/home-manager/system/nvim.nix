{...}: {
  programs.neovim = {
    # Let Home-manager install and manage neovim.
    enable = false;
    # Set EDITOR to nvim.
    defaultEditor = true;
  };
}
