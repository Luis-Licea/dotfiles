{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    plugins = {
      git = pkgs.yaziPlugins.git;

      # git = pkgs.fetchFromGitHub {
      #   owner = "yazi-rs";
      #   repo = "plugins";
      #   rev = "main"; # Or a specific commit/tag for stability
      #   sha256 = "sha256-..."; # Replace with actual hash from nix-prefetch-url
      # };
    };
    # initLua = ''
    #   require("git"):setup()
    # '';
  };

  environment.systemPackages = [
    # Needed for image previews.
    pkgs.ueberzugpp
  ];
}
