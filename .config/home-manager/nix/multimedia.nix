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
# systemd unit
  # mcomix ranger librewolf brave calibre chromium thunderbird share/nvim/sesions 
  home.packages = viewers ++ converters ++ downloaders ++ editors ++ compilers;
}
