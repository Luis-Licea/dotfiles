{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    plugins = {
      git = pkgs.yaziPlugins.git;
    };
  };

  environment.systemPackages = [
    # Needed for image previews.
    pkgs.ueberzugpp
  ];
}
