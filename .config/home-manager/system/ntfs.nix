{...}: {
  # Configure how NTFS removable disks should be mounted.
  environment.etc."udisks2/mount_options.conf".text = ''
    [defaults]
    ntfs_defaults=uid=$UID,gid=$GID,rw,relatime
    ntfs_allow=uid=$UID,gid=$GID,umask,dmask,fmask,locale,norecover,ignore_case,compression,nocompression,big_writes,nls,nohidden,sys_immutable,sparse,showmeta,prealloc
  '';

  services = {
    gvfs.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
  };
}
