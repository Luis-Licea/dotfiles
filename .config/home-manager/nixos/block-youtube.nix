{...}: let
  blockYoutube = false;
in {
  networking.extraHosts =
    if blockYoutube
    then ''
      # /etc/hosts - Block YouTube.
      127.0.0.1       www.youtube.com
      127.0.0.1       m.youtube.com
      127.0.0.1       youtube.com
      127.0.0.1       youtu.be
      127.0.0.1       ytimg.com
      127.0.0.1       l.google.com
      127.0.0.1       googlevideo.com
    ''
    else "";
}
