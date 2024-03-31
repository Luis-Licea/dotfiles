{pkgs, ...}:
with pkgs; let
  viewers = [
    bat
    calibre
    glow
    mcomix
    # mpv # Install as a system package for stability.
    nvimpager
    qview
    ueberzugpp
    zathura
  ];
  editors = [
    # sqlite
    kid3
    krita
    onlyoffice-bin
    sqlitebrowser
  ];
  converters = [
    catdoc
    imagemagick
    pandoc
    python311Packages.docx2txt
  ];
  downloaders = [
    yt-dlp
  ];
  compilers = [
    typst
    typst-fmt
    typst-lsp
  ];
  webBrowsers = [
    brave
    ungoogled-chromium
  ];
  archivers = [
    zip
    xz
    unzip
    p7zip
    gnutar
    zstd
  ];
in {
  home.packages =
    viewers
    ++ converters
    ++ downloaders
    ++ editors
    ++ compilers
    ++ webBrowsers
    ++ archivers;
}
