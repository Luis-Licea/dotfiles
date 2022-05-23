#!/usr/bin/bash

# TODO: Backup this file, VSCode settings.json, keybindings.json, .zshrc for oh-my-zsh, dolvim settings.

# Install using pacman.
pacman_programs=(
    # Development tools.

    boost               # C++ development headers.
    ccls                # Language server for C/C++.
    doxygen             # Documentation system for C/C++/Java/Python.
    gitui               # Git TUI client.
    qemu                # A generic and open source machine emulator and virtualizer
    shellcheck          # Shell script analysis tool.
    sourcetrail         # A cross-platform source explorer for C/C++ and Java.
    tldr                # Simplified man pages.
    vscodium            # Free/Libre Open Source Software Binaries of VSCode.

        ## Python setup.
        python-pip          # Intall pip3. NOTE: install virtualenv with `pip3 install virtualenv`.
        bpython             # Fancy command line interpreter.


    # Miscellaneous.
    # zathura             # Minimalistic document viewer.
    # evince              # GTK PDF Viewer.
    # lollypop            # Music player (no support for star ratings).
    audacium            # Free version of Audacity.
    cmus                # TUI music player.
    deja-dup            # File backups.
    firefox             # Firefox browser.
    firefox-extension-plasma-integration    # Player and Krunner integration.
    firefox-extension-privacy-redirect      # Redirect Youtube, Twitter, Instagram to alternatives.
    firefox-noscript    # Disable JavaScript.
    firefox-ublock-origin                   # Disable adds.
    krita               # Vector graphics.
    obs-strudio         # Recording studio.
    peek                # Screen recorder.
    strawberry-qt5      # Music player that supports lyrics and star ratings.
    strawberry-qt5      # Music player.
    thunderbird         # Email client.
    yt-dlp              # ty-dlp fork with added features and patches.
    most                # A terminal pager similar to 'more' and 'less'. NOTE: Set PAGER=most in .zshrc.

    # System
    p7zip               # Command line archiver with high compression ratio.

    # Vim setup.
    xclip               # Allows nvim to access Xorg system clipboard.

    # Texlive setup.
    biber               # Unicode-capable bibliography backend for BibLaTeX.
    minted              # Syntax highlighted source code for LaTeX. NOTE: run "pip3 install Pygments". Also, edit ifplatform.sty as shown in "https://github.com/wspr/will2e/pull/6/files". Also, add ".latexmkrc".

    # Font support for emojis, Microsoft Word documents, Asian languages, and more.
    noto-fonts-cjk      # Supports Chinese, Japanese, and Korean fonts.
    noto-fonts-emoji    # Supports emojis.

)

# Install using yaourt, yay, etc.
aur_programs=(

    # Miscellaneous.
    cht.sh-git          # Command-line client for cheat.sh.
    navi                # An interactive cheatsheet tool for the command-line
    mousai              # Music name detector. Complements Shortwave.
    drawing             # Simple image editing program.
    courtail            # Compresses images.
    identity            # Compares images side by side.
    textpieces          # Provides many text formatting options.
    shortwave           # Online radio.
    gnome-todo          # Keeps track of todo notes.
    khronos             # Simple activity time tracker.
    goldendict-git      # Feature rich dictionary.
    ttf-ms-fonts        # Supports Times New Roman fonts.
    dolvim              # Dolphin but Vim. NOTE: Enable Git, Show Hidden files in Context Menu.

    # Terminal setup.
    oh-my-zsh-git       # Read instructions after installation. There are additional steps. Add this to ~/.bashrc: "exec zsh". Make root have zsh as default shell: "ln -s $HOME/.zshrc /root/.zshrc".
    ttf-meslo-nerd-font-powerlevel10k # Symbol-patched font for powerlevel10k.
    zsh-theme-powerlevel10k # Theme for Zsh.

    # Neovim setup.
    ack                 # Perl-based grep for large heterogeneous code bases.
    neovim              # Provides improvements over Vim.
    nerd-fonts-source-code-pro # Needed by NERDTree. Can use Meslo NF instead.

    # LaTeX setup.
    texlive-most-doc    # Texdoc command for LaTeX package documentation.
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

    fcitx5-im           # Manage input method editors. NOTE: add env variables and locales.
    fcitx5-mozc-ut      # Improved Japanese conversion quality over fcitx5-mozc.
)

modern_unix=(
    # Install with pacman.
    bat       # A cat clone with syntax highlighting and Git integration.
    # exa       # A modern replacement for ls. (lsd is prettier by default)
    lsd       # The next gen file listing command. Backwards compatible with ls.
    git-delta # A viewer for git and diff output
    dust      # A more intuitive version of du written in rust.
    duf       # A better df alternative.
    broot     # A new way to see and navigate directory trees.
    fd        # A simple, fast and user-friendly alternative to find.
    ripgrep   # An extremely fast alternative to grep that respects your gitignore.
    ag        # A code searching tool similar to ack, but faster.
    fzf       # A general purpose command-line fuzzy finder.
    mcfly     # Fly through your shell history.
    choose    # A human-friendly and fast alternative to cut and sometimes awk.
    jq        # sed for JSON data.
    sd        # An intuitive find & replace CLI (sed alternative).
    cheat     # Create and view interactive cheatsheets on the command-line.
    tldr      # A community effort to simplify man pages with practical examples.
    bottom    # Yet another cross-platform graphical process/system monitor.
    glances   # Glances an Eye on your system (top/htop alternative).
    gtop      # System monitoring dashboard for terminal.
    hyperfine # A command-line benchmarking tool.
    gping     # ping, but with a graph.
    procs     # A modern replacement for ps written in Rust.
    httpie    # A modern, user-friendly command-line HTTP client for the API era.
    curlie    # The power of curl, the ease of use of httpie.
    xh        # A friendly and fast tool for sending HTTP requests. It reimplements as much as possible of HTTPie's excellent design, with a focus on improved performance.
    zoxide    # A smarter cd command inspired by z.
    dog       # A user-friendly command-line DNS client (dig on steroids).
)


# Install using plasma-discover.
flatpak_programs=(
    Breeze-gtk      # Fixes broken Application Style for GTK applications like GIMP.
)

# Install using VSCodium.
# VSCodium plugins to install using `codium --install-extension <extension name>
vscodium_extensions=(
    James-Yu.latex-workshop         # LaTeX builder and previewer.
    alefragnani.project-manager     # Easily switch between projects.
    cschleiden.vscode-github-actions# GitHub Actions workflows autocompletion.
    hediet.vscode-drawio            # Drawio integration for diagram creation.
    mhutchie.git-graph              # View a Git Graph of your repository, and perform Git actions from the graph.
    ms-python.python                # Provides Intellisense and Debuggin, 
    njpwerner.autodocstring         # Generates Python docstrings automatically. 
    shardulm94.trailing-spaces      # Highlight trailing spaces and delete them in a flash!
    streetsidesoftware.code-spell-checker   # Source code spell checker.
    vscodevim.vim                   # Vim emulation.
    zaaack.markdown-editor          # A full-featured WYSIWYG editor for markdown.
)

# VHDL setup not needed anymore.
    vhld_pacman_programs=(
        # VHDL setup for VSCodium.
        ghdl-llvm       # VHDL simulator. NOTE: Use VSCode TesoHDL plugin and run "pip3 install teroshdl".
        gtkwave         # Waveform viewer for VHDL.
    )
    vhdl_vscodium_extensions=(
        # VHDL setup for VSCodium.
        teros-technology.teroshdl       # IDE for GHDL simulation.
    )

# List of installers that I hope existed.
nonexistent_programs=(
    goldendict-en       # Goldendict English dictionaries.
    goldendict-es       # Goldendict Spanish dictionaries.
    imprimis            # Video game based on Tesseract.
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
        for program in "${programs[@]}";
        do
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