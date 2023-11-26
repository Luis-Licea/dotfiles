{
  pkgs,
  inputs,
  config,
  ...
}: let
  inherit (inputs) custom-dwl;
in {
  home.packages = with pkgs; [
    alacritty # Default DWL terminal.
    custom-dwl.packages.${system}.default
    dunst # Notification deamon.
    inotify-tools # Needed by swaybar IPC.
    rofi # dmenu replacement.
    swaybg
    waybar
    wireplumber
    wl-clipboard
  ];
}
