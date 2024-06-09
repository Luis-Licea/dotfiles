{pkgs, ...}: {
  boot.kernelModules = ["kvm-amd" "kvm-intel"];
  users.users.luis.extraGroups = ["libvirtd"];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  environment.systemPackages = with pkgs; [
    gnome.gnome-boxes # qemu

    # Note: Inside VM run: sudo apt install spice-webdavd spice-client-gtk
    spice
    spice-gtk
    spice-protocol
    virt-viewer
    #virtio-win # For Windows.
    #win-spice # For Windows.
  ];
  programs.virt-manager.enable = true;

  programs.dconf = {
    enable = true;
    profiles = {
      # A "user" profile with a database
      user.databases = [
        {
          settings = {
            "org/virt-manager/virt-manager/connections" = {
              autoconnect = ["qemu:///system"];
              uris = ["qemu:///system"];
            };
          };
        }
      ];
    };
  };
}
