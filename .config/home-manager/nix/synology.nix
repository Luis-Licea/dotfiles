{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "synology-drive-client"
    ];

  home.packages = with pkgs; [
    synology-drive-client
  ];
}
