{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) custom-dwl;
in {
  home.packages = with pkgs; [
    # alacritty # Default DWL terminal. Install a system package for stability.
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
