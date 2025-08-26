{pkgs, ...}:
with pkgs; let
  viewers = [
    # mpv # Install as a system package for stability.
    calibre
    image-roll # Simple image viewer with image crop functionality.
    mcomix
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
    zrythm
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
  finance = [
      # gnucash
  ];
in {
  home.packages =
    viewers
    ++ converters
    ++ downloaders
    ++ editors
    ++ compilers
    ++ webBrowsers
    ++ archivers
    ++ finance;
}
