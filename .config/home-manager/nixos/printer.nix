{pkgs, ...}: {
  # Enable CUPS to print documents. Add printers on: http://localhost:631/admin
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [gutenprint];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true; # Open UPD port 5353 to discover WiFi printer.
    };
  };
  hardware.sane = {
    enable = true;
    extraBackends = with pkgs; [sane-airscan];
    disabledDefaultBackends = ["escl"];
  };
}
