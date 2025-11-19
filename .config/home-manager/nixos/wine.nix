{pkgs, ...}: {
  # Install OpenGL drivers to avoid "Failed to Initialize Graphics System" error.
  hardware.graphics.enable32Bit = true; # Equivalent of hardware.opengl.driSupport32Bit = true;
  # hardware.alsa.enablePersistence = true;

  environment.systemPackages = with pkgs; [
    # support both 32-bit and 64-bit applications
    # wineWowPackages.stable

    # support 32-bit only
    # wine

    # support 64-bit only
    # (wine.override {wineBuild = "wine64";})

    # support 64-bit only
    # wine64

    # wine-staging (version with experimental features)
    # wineWowPackages.staging

    # Use winetricks to install the following Rocksmith DLLS: vcrun2010 d3dx9_43 d3dx9
    # - d3dx9_43.dll: Direct X
    # - MSVCP100.dll: Microsoft Visual C++ 2010 Redistributable Package
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];
}
