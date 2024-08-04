{...}: {
  # Configure how NTFS removable disks should be mounted.
  environment.etc."udisks2/mount_options.conf".text = ''
    [defaults]
    ntfs_defaults=uid=$UID,gid=$GID,prealloc
  '';

  services.udisks2.enable = true;
}
