{...}: {
  # Enable sound with pipewire.
  security.rtkit.enable = true; # Optional but recommended.

  # Audio settings.
  services.pipewire = {
    alsa.enable = true;
    enable = true;
    # jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Needed for Zrythm.
  # users.extraUsers.luis.extraGroups = ["jackaudio"];
  # services.jack = {
  #   jackd.enable = true;
  #   # support ALSA only programs via ALSA JACK PCM plugin
  #   alsa.enable = false;
  #   # support ALSA only programs via loopback device (supports programs like Steam)
  #   loopback = {
  #     enable = true;
  #     # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
  #     #dmixConfig = ''
  #     #  period_size 2048
  #     #'';
  #   };
  # };
}
