{pkgs, ...}:
with pkgs; let
  development = [
    # Development tools.
    entr                    # Run arbitrary commands when files change.
    keychain                # A front-end to ssh-agent, allowing one long-running ssh-agent process per system, rather than per login
    nethogs                 # A net top tool which displays traffic used per process instead of per IP or interface.
    tig                     # Text-mode interface for Git.
    pax                     # Portable Archive Interchange - the POSIX standard archive tool for cpio and tar formats
    atool                   # A script for managing file archives of various types.
    sourcetrail             # A cross-platform source explorer for C/C++ and Java.
    scrcpy                  # Needs `adb` from `anroid-tools`. Display and control your Android device; Enable Android debugging mode, connect USB, and done!
  ];
  music = [
    # Music player.
    mpd        # Flexible, powerful, server for playing music.
    timidity # For mpd. A MIDI to WAVE converter and player.
    ncmpcpp    # An mpd client like ncmpc with some new features.
    mpdris2    # MPRIS2 support for MPD. Use AUR.
    kid3       # An MP3, Ogg/Vorbis and FLAC tag editor, KDE version
  ];
  video = [
    # Video player.
    mpv       # The best video player.
    mpv-mpris # MPRIS plugin for mpv.
  ];
  miscellaneous = [
    # Miscellaneous.
    languagetool # An open source language checker.
    termdown     # Countdown timer and stopwatch in your terminal.
    calibre      # Ebook management application
    termshark    # Terminal UI for tshark, inspired by Wireshark.
    newsboat     # An RSS/Atom feed reader for text terminals
    kdeconnect   # Adds communication between KDE and your smartphone.
    rmlint       # Tool to remove duplicates much faster than fdupes
    syncthing    # Continuous Replication / Cluster Synchronization Thing

    libsixel          # Provides a codec for DEC SIXEL graphics and some converter programs
    lf                # A terminal file manager inspired by ranger
    kitty             # A modern, hackable, featureful, OpenGL-based terminal emulator.
    sshfs             # For kdeconnect. FUSE client based on the SSH File Transfer Protocol.
    sddm              # QML based X11 and Wayland display manager.
    zathura           # Minimalistic document viewer.
    zathura-cb        # Add comic-book support to zathura.
    zathura-pdf-mupdf # Add PDF, ePub, and OpenXPS support to zathura.
    cpdf-bin          # Coherent PDF: merge, encrypt, decrypt, scale, crop, rotate, bookmarks, stamp, logos, page numbers, compress, etc.
    # evince              # GTK PDF Viewer.
    # lollypop            # Music player (no support for star ratings).
    # pdfarranger         # Merge, split, rotate, crop and rearrange PDFs.
    # gscan2pdf           # PDF tool. Can remove background from scanned PDFs.
    sc-im                                # A spreadsheet program based on SC.
    qt5ct                                # Qt5 Configuration Utility.
    audacium                             # Free version of Audacity.
    deja-dup                             # File backups.
    firefox                              # Firefox browser.
    firefox-extension-plasma-integration # Player and Krunner integration.
    firefox-extension-privacy-redirect   # Redirect Youtube, Twitter, Instagram to alternatives.
    firefox-noscript                     # Disable JavaScript.
    firefox-ublock-origin                # Disable adds.
    krita                                # Vector graphics.
    obs-strudio                          # Recording studio.
    peek                                 # Screen recorder.
    strawberry-qt5                       # Music player that supports lyrics and star ratings.
    thunderbird                          # Email client.
    yt-dlp                               # ty-dlp fork with added features and patches.
    clipgrab                             # A video downloader and converter for YouTube, Veoh, DailyMotion, MyVideo, ...
    nitrogen                             # Background browser and setter for X windows.

    most      # A terminal pager similar to 'more' and 'less'. NOTE: Set PAGER=most in .zshrc.
    trash-cli # Command line trashcan (recycle bin) interface.

    # Miscellaneous.
    xonsh                    # Python-powered, cross-platform, Unix-gazing shell
    asciiquarium             # An aquarium/sea animation in ASCII art
    sl                       # Steam locomotive ascii art.
    python-gtts              # Python library and CLI tool to interface with Google Translate's text-to-speech API

    toilet                   # free replacement for the FIGlet utility.                         # alias toilet='toilet -F crop -F border -f mono12' # -F metal -F rainbow --html
    toilet-fonts             # Additional asciiart fonts for toilet (adapted from figlet-fonts) # alias toilet-filters='toilet --filter list'
    mutt-wizard-git          # Auto-configure neomutt and isync/mpop with safe passwords (IMAP/POP3/SMTP)
    abook                    # Text-based addressbook designed for use with Mutt.
    pipe-viewer-git          # A lightweight YouTube client for Linux (CLI/GTK).
    nvimpager-git            # Use nvim to view manpages, diffs with syntax highlighting
    xdg-ninja-git            # A shell script that checks $HOME for unwanted files.
    cht.sh-git               # Command-line client for cheat.sh.
    navi                     # An interactive cheatsheet tool for the command-line
    mousai                   # Music name detector. Complements Shortwave.
    drawing                  # Simple image editing program.
    courtail                 # Compresses images.
    identity                 # Compares images side by side.
    textpieces               # Provides many text formatting options.
    shortwave                # Online radio.
    gnome-todo               # Keeps track of todo notes.
    khronos                  # Simple activity time tracker.
    goldendict-webengine-git # A feature-rich dictionary supporting multiple dictionary formats.
    ttf-ms-fonts             # Supports Times New Roman fonts.
    htop-vim                 # Interactive process viewer with a Vim keybindings.
    dolvim                   # Dolphin but Vim. NOTE: Enable Git, Show Hidden files in Context Menu.
  ];
  fileManager = [
    # Terminal file manager and viewer.
    ranger   # Simple, vim-like file manager.
    dragon-drop # For Ranger. Drag-and-drop source for X or Wayland.
    ueberzug # Display images in X11 in ranger. NOTE: Configure rc.conf.
    sxiv     # Simple X Image Viewer.
  ];
  system = [
    # System
    p7zip       # Command line archiver with high compression ratio.
    simple-scan # Simple scanning utility.
  ];
  texlive = [
    # Texlive setup.
    biber  # Unicode-capable bibliography backend for BibLaTeX.
    minted # Syntax highlighted source code for LaTeX. NOTE: run "pip3 install Pygments". Also, edit ifplatform.sty as shown in "https://github.com/wspr/will2e/pull/6/files". Also, add ".latexmkrc".
    rubber # A wrapper for LaTeX and friends.
  ];
  fonts = [
    # Font support for emojis, Microsoft Word documents, Asian languages, and more.
    noto-fonts-cjk   # Supports Chinese, Japanese, and Korean fonts.
    noto-fonts-emoji # Supports emojis.
  ];
  dictionaries = [
    # Dictionaries and spell checkers.
    sdcv                              # StarDict Console Version.
    sdtui-git                         # StarDict TUI and GUI
    stardict-wordnet                  # WordNet dictionary for StarDict.
    stardict-dictd-moby-thesaurus     # Moby Thesaurus II (English) for StarDict
    stardict-wikt-en-all              # English Wiktionary All Languages for StarDict
    stardict-dictd_www.dict.org_gcide # Collab. Internat. Dict. of English for stardict et al.
  ];
  spelling = [
    write-good # Naive linter for English prose.
    aspell     # A spell checker designed to eventually replace Ispell
    aspell-en  # English dictionary for aspell
  ];
  modernUnix = [
    hyperfine # A command-line benchmarking tool.
    gping     # ping, but with a graph.
    procs     # A modern replacement for ps written in Rust.
    httpie    # A modern, user-friendly command-line HTTP client for the API era.
    curlie    # The power of curl, the ease of use of httpie.
    xh        # A friendly and fast tool for sending HTTP requests. It reimplements as much as possible of HTTPie's excellent design, with a focus on improved performance.
  ];
  pretty = [
    cava     # Console-based Audio Visualizer for Alsa
    pfetch   # A pretty system information tool written in POSIX sh.
    cbonsai  # A bonsai tree generator, written in C using ncurses.
    pipes.sh # Animated pipes terminal screensaver.
  ];
  vscodeExtension = with vscode-extensions; [
    James-Yu.latex-workshop     # LaTeX builder and previewer.
    alefragnani.project-manager # Easily switch between projects.
    cschleiden.vscode-github-actions# GitHub Actions workflows autocompletion.
    hediet.vscode-drawio                  # Drawio integration for diagram creation.
    mhutchie.git-graph                    # View a Git Graph of your repository, and perform Git actions from the graph.
    ms-python.python                      # Provides Intellisense and Debuggin,
    njpwerner.autodocstring               # Generates Python docstrings automatically.
    shardulm94.trailing-spaces            # Highlight trailing spaces and delete them in a flash!
    streetsidesoftware.code-spell-checker # Source code spell checker.
    vscodevim.vim                         # Vim emulation.
    zaaack.markdown-editor                # A full-featured WYSIWYG editor for markdown.
  ];
in {
  home.packages = development ++ music ++ video ++ miscellaneous ++ fileManager
    ++ system ++ texlive ++ fonts ++ dictionaries ++ spelling ++ modernUnix ++
    pretty;

  programs.vscode.extensions = vscodeExtension;
}
