{
  pkgs,
  ...
}: {
  # Load the sequencer and midi kernel modules.
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
    pulse.enable = true;
  };

  # Must disable pulseaudio to allow for the pipewire pulseaudio emulation.
  services.pulseaudio.enable = false;

  environment.systemPackages = with pkgs; [
    reaper
    # cp "$(nix-instantiate --eval-only --expr '(import <nixpkgs> {}).reaper-reapack-extension.outPath' --raw)/UserPlugins"/* ~/.config/REAPER/UserPlugins/
    reaper-reapack-extension
    x42-avldrums # Various drumkits.
    geonkick # Beep-boop sounds, like a heart monitor.
    helm # Amazing synth.
    lsp-plugins # Cool plugins https://lsp-plug.in/?page=plugins
    zynaddsubfx # Piano, Guitar, Bass synths

    # Not interesting/useful.
    # vmpk # Virtual keyboard, but not does not integrate easily.
    # show-midi # Does not detect vmpk

    # Need testing:
    # bristol
    # calf
    # carla
    # noise-repellent
    # paulstretch
    # qpwgraph
    # sfizz # Crappy synth.
    # swh_lv2
    # zam-plugins

    surge
    x42-gmsynth
    x42-plugins

    # alsa-lib
    # alsa-utils
    # ardour
    # audacious
    # ffado
    # jack2
    # jack_capture
    # libjack2
    # lmms
    # pavucontrol
    # pkgs-brian.ardour
    # pulseaudioFull
    # qjackctl
    # show-midi
    # spotify
    # surge
    # x42-gmsynth
    # x42-plugins
    # zrythm
    # zynaddsubfx # Plugin
  ];
}
