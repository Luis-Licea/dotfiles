{pkgs, ...}: {
  # Install OpenGL drivers to avoid "Failed to Initialize Graphics System" error.
  hardware.graphics.enable32Bit = true;


  environment.systemPackages = with pkgs; [
    # Use winetricks to install the following Rocksmith DLLS: vcrun2010 d3dx9_43 d3dx9
    # - d3dx9_43.dll: Direct X
    # - MSVCP100.dll: Microsoft Visual C++ 2010 Redistributable Package
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];
}
# winetricks sound=alse
# winecfg (play test sound button and quickly increase volume, which will be 0
# for alsa)
# - select Windows 10
