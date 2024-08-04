{...}: {
  # Enable sound with pipewire.
  security.rtkit.enable = true; # Optional but recommended.

  # Audio settings.
  services.pipewire = {
    alsa.enable = true;
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
