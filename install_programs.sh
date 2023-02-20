#!/usr/bin/env bash

# NOTE: Use 'locate' command more often! It is similar to fzf.
# TODO: Backup this file, VSCode settings.json, keybindings.json, .zshrc for oh-my-zsh, dolvim settings.

# Install using pacman.
pacman_programs=(

    # Development tools.
    zim                     # A WYSIWYG text editor that aims at bringing the concept of a wiki to the desktop.
    zim-tools               # Various ZIM command line tools.
    sqlite-doc              # Static HTML website files, SQL Syntax, and C/C++ interface specs.
    nvm                     # Node Version Manager.
    entr                    # Run arbitrary commands when files change.
    keychain                # A front-end to ssh-agent, allowing one long-running ssh-agent process per system, rather than per login
    neovide                 # No Nonsense Neovim Client in Rust.
    nethogs                 # A net top tool which displays traffic used per process instead of per IP or interface.
    tig                     # Text-mode interface for Git.
    awesome                 # Highly configurable framework window manager
    xev                     # Print contents of X events
    bash-completion         # Programmable completion for the bash shell.
    zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
    kwin-bismuth-bin        # KDE tiling window manager.
    include-what-you-use    # A tool for use with clang to analyze #includes in C and C++ source files
    tesseract-data-eng      # Tesseract OCR data eng.
    cppcheck                # A tool for static C/C++ code analysis
    gocr                    # OCR (Optical Character Recognition) program, which converts scanned images of text back to text files
    gtk4                    # GObject-based multi-platform GUI toolkit
    gtk4-demos              # GObject-based multi-platform GUI toolkit (demo applications)
    gtk4-docs               # GObject-based multi-platform GUI toolkit (documentation)
    gtkmm-4.0               # C++ bindings for GTK 4
    gtkmm-4.0-docs          # C++ bindings for GTK 4 (documentation)
    rustup                  # The Rust toolchain installer.
    pax                     # Portable Archive Interchange - the POSIX standard archive tool for cpio and tar formats
    atool                   # A script for managing file archives of various types.
    gnupg                   # Complete and free implementation of the OpenPGP standard
    kgpg                    # A GnuPG frontend
    gtest                   # Google Test - C++ testing utility.
    time                    # Benchmarking tool.
    boost                   # C++ development headers.
    ccls                    # Language server for C/C++.
    doxygen                 # Documentation system for C/C++/Java/Python.
    gitui                   # Git TUI client.
    qemu                    # A generic and open source machine emulator and virtualizer
    shellcheck              # Shell script analysis tool.
    sourcetrail             # A cross-platform source explorer for C/C++ and Java.
    tldr                    # Simplified man pages.
    vscodium-bin            # Free/Libre Open Source Software Binaries of VSCode.
    hub                     # CLI interface for Github.
    python-pip              # Intall pip3. NOTE: install virtualenv with `pip3 install virtualenv`.
    pandoc-bin              # Pandoc executable only, without 750MB Haskell depends/makedepends.
    tcc                     # Tiny C Compiler.
    opengl-man-pages        # OpenGL Man Pages - OpenGL 4.x.

    # Music player.
    mpd        # Flexible, powerful, server for playing music.
    timidity++ # For mpd. A MIDI to WAVE converter and player.
    ncmpcpp    # An mpd client like ncmpc with some new features.
    mpdris2    # MPRIS2 support for MPD. Use AUR.
    kid3       # An MP3, Ogg/Vorbis and FLAC tag editor, KDE version

    # Video player.
    mpv       # The best video player.
    mpv-mpris # MPRIS plugin for mpv.

    # Miscellaneous.
    languagetool # An open source language checker.
    termdown     # Countdown timer and stopwatch in your terminal.
    calibre      # Ebook management application
    termshark    # Terminal UI for tshark, inspired by Wireshark.
    newsboat     # An RSS/Atom feed reader for text terminals
    kdeconnect   # Adds communication between KDE and your smartphone.
    rmlint       # Tool to remove duplicates much faster than fdupes
    syncthing    # Continuous Replication / Cluster Synchronization Thing

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

    # Terminal file manager and viewer.
    ranger   # Simple, vim-like file manager.
    ueberzug # Display images in X11 in ranger. NOTE: Configure rc.conf.
    sxiv     # Simple X Image Viewer.

    # System
    p7zip       # Command line archiver with high compression ratio.
    simple-scan # Simple scanning utility.

    # Vim setup.
    xclip # Allows nvim to access Xorg system clipboard.
    gvim  # Install vim and clipboard support.

    # Texlive setup.
    biber  # Unicode-capable bibliography backend for BibLaTeX.
    minted # Syntax highlighted source code for LaTeX. NOTE: run "pip3 install Pygments". Also, edit ifplatform.sty as shown in "https://github.com/wspr/will2e/pull/6/files". Also, add ".latexmkrc".
    rubber # A wrapper for LaTeX and friends.

    # Font support for emojis, Microsoft Word documents, Asian languages, and more.
    noto-fonts-cjk   # Supports Chinese, Japanese, and Korean fonts.
    noto-fonts-emoji # Supports emojis.
)

# Install using yaourt, yay, etc.
aur_programs=(

    # Wayland
    waybar                # Highly customizable Wayland bar for Sway and Wlroots based compositors
    xorg-xlsclients       # List client applications running on a display.
    swaybg                # wallpaper tool for wayland compositars.
    swaylock              # Screen locker for Wayland.
    wl-clipboard          # Command-line copy/paste utilities for Wayland.
    networkmanager-openrc # OpenRC networkmanager init script.
    grimshot              # A helper for screenshots within sway.
    vim-dwm-git           # Dynamic Window Manager behaviour for Vim
    wlr-randr-git         # Utility to manage outputs of a Wayland compositor.
    inotify-tools         # A C library and programs for the inotify interface.

    # Volume control.
    pacmixer # alsamixer alike for PulseAudio.

    # Dictionaries and spell checkers.
    sdcv                              # StarDict Console Version.
    sdtui-git                         # StarDict TUI and GUI
    stardict-wordnet                  # WordNet dictionary for StarDict.
    stardict-dictd-moby-thesaurus     # Moby Thesaurus II (English) for StarDict
    stardict-wikt-en-all              # English Wiktionary All Languages for StarDict
    stardict-dictd_www.dict.org_gcide # Collab. Internat. Dict. of English for stardict et al.

    write-good # Naive linter for English prose.
    aspell     # A spell checker designed to eventually replace Ispell
    aspell-en  # English dictionary for aspell

    # Miscellaneous.
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

    # Terminal setup.
    ttf-meslo-nerd-font-powerlevel10k # Symbol-patched font for powerlevel10k.
    zsh-theme-powerlevel10k           # Theme for Zsh.

    # Neovim setup.
    silver-searcher-git        # The Silver Searcher: Better than ack and grep.
    neovim                     # Provides improvements over Vim.
    uctags-git                 # Universal ctags (patched to allow installing alongside original ctags).
    nerd-fonts-source-code-pro # Needed by NERDTree. Can use Meslo NF instead.

    # LaTeX setup.
    texlive-most-doc        # Texdoc command for LaTeX package documentation.
    meta-group-texlive-most # texlive-most group contains bibtexextra, core, fontsextra, formatsetxtra, etc:
    # texlive-bibtexextra   Additional BibTeX styles and bibliography databases
    # texlive-core          Core distribution
    # texlive-fontsextra    all sorts of extra fonts
    # texlive-formatsextra  collection of extra TeX 'formats'
    # texlive-games         Setups for typesetting various board games, including chess
    # texlive-humanities    LaTeX packages for law, linguistics, social sciences, and humanities
    # texlive-latexextra    Large collection of add-on packages for LaTeX
    # texlive-music         Music typesetting packages
    # texlive-pictures      Packages for drawings graphics
    # texlive-pstricks      Additional PSTricks packages
    # texlive-publishers    LaTeX classes and packages for specific publishers
    # texlive-science       Typesetting for mathematics, natural and computer sciences

    fcitx5-im # Manage input method editors. NOTE: add env variables and locales.

    dragon-drop # For Ranger. Drag-and-drop source for X or Wayland.
)

dont_install=(
    # There is a problem with this package: the command 'omz update' won't work.
    oh-my-zsh-git #  To mae root have zsh as default shell: "ln -s $HOME/.zshrc /root/.zshrc".
)

printer_programs=(
    # Fix "unable to locate printer" error:
    # Add *mdns_minimal [NOTFOUND=return]* before *resolve* in /etc/nsswitch.conf
    # https://wiki.archlinux.org/title/Avahi#Hostname_resolution

    avahi                 # Service Discovery for Linux using mDNS/DNS-SD
    system-config-printer # A CUPS printer configuration tool and status applet
)

modern_unix=(
    # Install with pacman.
    bat # A cat clone with syntax highlighting and Git integration.
    # exa       # A modern replacement for ls. (lsd is prettier by default)
    lsd   # The next gen file listing command. Backwards compatible with ls.
    dog   # A user-friendly command-line DNS client (dig on steroids).
    fzf   # A general purpose command-line fuzzy finder.
    cheat # Create and view interactive cheatsheets on the command-line.
    tldr  # A community effort to simplify man pages with practical examples.

    # Not experimened with.
    git-delta # A viewer for git and diff output
    dust      # A more intuitive version of du written in rust.
    duf       # A better df alternative.
    broot     # A new way to see and navigate directory trees.
    fd        # A simple, fast and user-friendly alternative to find.
    ripgrep   # An extremely fast alternative to grep that respects your gitignore.
    ag        # A code searching tool similar to ack, but faster.
    mcfly     # Fly through your shell history.
    choose    # A human-friendly and fast alternative to cut and sometimes awk.
    jq        # sed for JSON data.
    sd        # An intuitive find & replace CLI (sed alternative).
    hyperfine # A command-line benchmarking tool.
    gping     # ping, but with a graph.
    procs     # A modern replacement for ps written in Rust.
    httpie    # A modern, user-friendly command-line HTTP client for the API era.
    curlie    # The power of curl, the ease of use of httpie.
    xh        # A friendly and fast tool for sending HTTP requests. It reimplements as much as possible of HTTPie's excellent design, with a focus on improved performance.
    zoxide    # A smarter cd command inspired by z.
)

pretty=(
    cava     # Console-based Audio Visualizer for Alsa
    pfetch   # A pretty system information tool written in POSIX sh.
    cbonsai  # A bonsai tree generator, written in C using ncurses.
    pipes.sh # Animated pipes terminal screensaver.
)

# Use in Ubuntu 18.04 where.
npm=(
    @funboxteam/languagetool-node # An open source language checker.
    chai@4.3.6                    # TDD assertion library.
    mocha@10.1.0                  # Test framework.
    write-good@1.0.8              # An open source language checker.
    backstopjs                    # Test visual regressions.
    chokidar                      # Monitor file system changes.

    # ESLint plugins for JavaScript and TypeScript.
    eslint-config-standard@17.0.0
    eslint-plugin-import@2.26.0
    eslint-plugin-n@15.5.0
    eslint-plugin-promise@6.1.1
    eslint@8.25.0
)

# Install using plasma-discover.
flatpak_programs=(
    Breeze-gtk # Fixes broken Application Style for GTK applications like GIMP.
)

# Install using VSCodium.
# VSCodium plugins to install using `codium --install-extension <extension name>
vscodium_extensions=(
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
)

pip3_programs=(
    cppman       # C++ man page documentation.
    cmake-format # Source code formatter for CMake list files.
    cmakelint    # CMake files and reports style issues
)

# List of installers that I hope existed.
nonexistent_programs=(
    goldendict-en # Goldendict English dictionaries.
    goldendict-es # Goldendict Spanish dictionaries.
    imprimis      # Video game based on Tesseract.
)

# Programs I would like to contribute to.
want_to_contribute=(
    goldendict-git
    imprimis
)

function install_programs() {
    # Save first argument in a variable, the name of the package manager.
    local manager="$1"
    # Shift all arguments to the left (original $1 gets lost).
    shift
    # Rebuild the array with rest of arguments.
    local programs=("$@")

    if [ "$update" == "1" ]; then
        # Syncrhonize and update.
        $manager -Suy
        # Partial upgrades create problems.
        # elif [ "$syncrhonize" == "1" ]; then
        #        # Syncrhonize without updating.
        #        $manager -Sy
    fi

    if [ "$together" == "1" ]; then
        # Install all programs at once.

        # Join all array elements into a string.
        programs=$(printf "%s " "${programs[@]}")
        # Print installation command.
        echo $manager -S $programs
        # Execute installation.
        $manager -S $programs

        # Exit after installing all programs.
        exit
    fi

    # If not installing programs together, install individually.
    # For every program:
    for program in "${programs[@]}"; do
        # Get the program version.
        program_version=$($manager -Q $program)
        # If there is no version number:
        if [ "$program_version" == "" ]; then
            # Install program.
            echo "$manager -S $program"
            $manager -S $program
        else
            echo Installed with $manager: $program
        fi
    done
}

# echo "Syncrhonize before installing (1 for yes/0 for no)?" && read synchronize
echo "Update before installing (1 for yes/0 for no)?" && read update
echo "Install all packages at together (1 for yes/0 for no)?" && read together

# Install pacman programs.
install_programs "sudo pacman" "${pacman_programs[@]}"
# Install yaourt programs.
install_programs "yaourt" "${aur_programs[@]}"
