{
  pkgs,
  config,
  ...
}: {
  # Needed to make Zsh the default shell.
  programs = {
    zsh = {
      # Whether to configure zsh as an interactive shell.
      enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = ["vi-mode" "git"];
      };
    };

    bash.shellAliases = config.programs.zsh.shellAliases;
  };

  environment.systemPackages = with pkgs; [
    nushell
  ];

  # This option defines the default shell assigned to user accounts. This can
  # be either a full system path or a shell package. This must not be a store
  # path, since the path is used outside the store (in particular in
  # /etc/passwd).
  users.defaultUserShell = pkgs.zsh;

  # Enable users to log in with Bash, ZSh, and Nushell shells in GDM.
  environment.shells = with pkgs; [bashInteractive zsh nushell];
}
