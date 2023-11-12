{pkgs, ...}:
with pkgs; let
  viewers = [
    bat
    calibre
    glow
    mcomix
    mpv
    nvimpager
    qview
    ueberzugpp
    zathura
  ];
  editors = [
    # sqlite
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
in {
  home.packages = viewers ++ converters ++ downloaders ++ editors ++ compilers;
}
