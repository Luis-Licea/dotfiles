{pkgs, ...}: {
  # AMD Radeon RX 580 Series
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages_5.clr.icd
  ];
  environment.systemPackages = with pkgs; [
    clinfo
    rocmPackages_5.rocminfo
    # mesa.opencl
    # zluda
    openai-whisper
    # openai-whisper-cpp
  ];
  environment.variables = {
    ROC_ENABLE_PRE_VEGA = 1;
  };
  # https://github.com/openai/whisper/discussions/55#discussioncomment-4504980
  users.users.luis = {
    extraGroups = ["render" "video"];
  };
}
