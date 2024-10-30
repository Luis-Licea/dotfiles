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
    eartag
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
    gnutar
    p7zip
    unrar-wrapper
    unzip
    xz
    zip
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
