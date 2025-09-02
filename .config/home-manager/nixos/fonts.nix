{pkgs, ...}: {
  # Install fonts system-wide.
  fonts = {
    packages = with pkgs; [
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.meslo-lg
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-emoji
      noto-fonts-extra
      noto-fonts-lgc-plus
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
