{
  inputs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    # xdg-utils # for opening default programs when clicking links
    # swaylock
    # swayidle
    # grim # screenshot functionality
    # slurp # screenshot functionality
    # mako # notification system developed by swaywm maintainer
    # wdisplays # tool to configure displays
  ];
}
