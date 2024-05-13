{pkgs, ...}: {
  # Install fonts system-wide.
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-color-emoji
      font-awesome
      (nerdfonts.override {fonts = ["Meslo" "FiraCode"];})
    ];
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      # Print valid font names:
      # find -L /run/current-system/sw/share/X11/fonts -type f -exec fc-query -f "%{family[0]}\n" {} \; | sort | uniq
      defaultFonts = {
        monospace = ["FiraCode Nerd Font Mono" "MesloLGS Nerd Font Mono" "Noto Sans Mono" "DejaVu Sans Mono"];
        serif = ["Noto Serif" "DejaVu Serif"];
        sansSerif = ["Noto Sans" "DejaVu Sans"];
      };
    };
  };
}
