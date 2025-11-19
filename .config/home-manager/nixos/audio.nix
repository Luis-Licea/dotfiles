{
  pkgs,
  ...
}: {
  # Load the sequencer and midi kernel modules.
  boot.kernelModules = ["snd-seq" "snd-rawmidi"];
  users.extraUsers.luis.extraGroups = ["audio" "realtime"];

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    # jack.enable = true;
    pulse.enable = true;
  };

  # Must disable pulseaudio to allow for the pipewire pulseaudio emulation.
  services.pulseaudio.enable = false;

  # Needed for Zrythm.
  # security.pam.loginLimits = [
  #   {
  #     domain = "@audio";
  #     item = "rtprio";
  #     type = "-";
  #     value = "95";
  #   }
  #   {
  #     domain = "@audio";
  #     item = "memlock";
  #     type = "-";
  #     value = "unlimited";
  #   }
  # ];

  # # Allow detection of VST plugins like Helm.
  # environment.variables = let
  #   makePluginPath = format:
  #     (lib.makeSearchPath format [
  #       "$HOME/.nix-profile/lib"
  #       "$HOME/.local/state/nix/profile/lib"
  #       "/run/current-system/sw/lib"
  #       "/etc/profiles/per-user/$USER/lib"
  #     ])
  #     + ":$HOME/.${format}";
  # in {
  #   DSSI_PATH = makePluginPath "dssi";
  #   LADSPA_PATH = makePluginPath "ladspa";
  #   LV2_PATH = makePluginPath "lv2";
  #   LXVST_PATH = makePluginPath "lxvst";
  #   VST_PATH = makePluginPath "vst";
  #   VST3_PATH = makePluginPath "vst3";
  # };

  environment.systemPackages = with pkgs; [
    reaper
    reaper-reapack-extension
    alsa-utils

    # ardour
    # zrythm

    # carla
    # calf
    geonkick
    helm
    lsp-plugins
    # noise-repellent
    # paulstretch
    # sfizz
    # surge
    # swh_lv2
    vmpk
    x42-avldrums
    # x42-gmsynth
    # x42-plugins
    zam-plugins
    # zynaddsubfx # Plugin

    # ffado
    # alsa-utils
    # pkgs-brian.ardour
    # spotify
    # alsa-lib
    # libjack2
    # jack2
    # qjackctl
    # pavucontrol
    # jack_capture
    # pulseaudioFull
    # audacious
    # qpwgraph
    # show-midi
    # mopidy
    # mopidy-bandcamp
    # mopidy-iris
    # mopidy-notify
    # mopidy-spotify
    # mopidy-soundcloud
    # lmms
    # lsp-plugins
  ];
}
