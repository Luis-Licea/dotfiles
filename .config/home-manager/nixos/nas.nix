{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    synology-drive-client
  ];
  # environment.systemPackages = [
  #   (pkgs.synology-drive-client.overrideAttrs
  #     (oldAttrs: rec {
  #       # https://www.synology.com/en-uk/releaseNote/SynologyDriveClient
  #       version = "4.0.1-17885";
  #       buildNumber = lib.last (lib.splitString "-" version);
  #       baseUrl = "https://global.synologydownload.com/download/Utility/SynologyDriveClient";
  #       src = pkgs.fetchurl {
  #         url = "${baseUrl}/${version}/Ubuntu/Installer/synology-drive-client-${buildNumber}.x86_64.deb";
  #         sha256 = "sha256-DMHqh8o0RknWTycANSbMpJj133/MZ8uZ18ytDZVaKMg=";
  #       };
  #       
  #       autoPatchelfIgnoreMissingDeps = [
  #         "libnautilus-extension.so.4"
  #         "libQt5Pdf.so.5"
  #       ];
  #       nativeBuildInputs =
  #         oldAttrs.nativeBuildInputs
  #         ++ [
  #           # error: auto-patchelf could not satisfy dependency libnautilus-extension.so.4 wanted by /nix/store/glgwpjdz6n9464vyhkbq3k92kif9467i-synology-drive-client-4.0.1-17885/lib/x86_64-linux-gnu/nautilus/extensions-4/libnautilus-drive-extension.so
  #           pkgs.nautilus # Needed for missing .so file
  #           # error: auto-patchelf could not satisfy dependency libQt5Pdf.so.5 wanted by /nix/store/vlfzqycb8vawrvvyz9w4fcb7v1kwhw1m-synology-drive-client-4.0.1-17885/opt/Synology/SynologyDrive/package/cloudstation/lib/plugins/imageformats/libqpdf.so
  #           # pkgs.qt5.qtwebengine
  #         ];
  #     }))
  # ];
}
