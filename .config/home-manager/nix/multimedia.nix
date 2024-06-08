{pkgs, ...}:
with pkgs; let
  viewers = [
    calibre
    mcomix
    # mpv # Install as a system package for stability.
    qview
    ueberzugpp
    zathura
  ];
  editors = [
    kid3
    krita
    onlyoffice-bin
    soundconverter
    sqlite
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
