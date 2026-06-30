{...}: {
  # Equivalent to `/etc/environment`.
  environment.variables = {
    # Allow fcitx5 to change keyboard layout in alacritty.
    WINIT_UNIX_BACKEND = "x11";
  };
}
