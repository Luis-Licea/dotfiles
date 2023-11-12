{ pkgs, ... }: {
  # Query font names:
  # find -L ~/.nix-profile/share/fonts/ -type f -exec fc-query -f "%{family[0]}\n" {} \; | sort | uniq
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    (nerdfonts.override {fonts = ["Meslo" "FiraCode"];})
  ];

  fonts.fontconfig.enable = true;
}
