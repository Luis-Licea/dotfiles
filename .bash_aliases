#!/usr/bin/env bash

# No Internal Field Separator. To split spaces, newlines, and tabs: IFS=$' \n\t'
unset IFS

################################################################################
# Preferred editor for local and remote sessions
################################################################################

export EDITOR=nvim
export VISUAL="$EDITOR"
if [[ -v SSH_CONNECTION ]]; then
    if [[ $(command -v nvim) ]]; then
        export EDITOR=nvim
    elif [[ $(command -v vim) ]]; then
        export EDITOR=vim
    elif [[ $(command -v vi) ]]; then
        export EDITOR=vi
    fi
fi

if [[ $(command -v nvimpager) ]]; then
    export PAGER=nvimpager
elif [[ $(command -v most) ]]; then
    export PAGER=most
fi

################################################################################
# Ranger.
################################################################################

# Disable loading Ranger's global configuration files because custom
# configurations are provided.
export RANGER_LOAD_DEFAULT_RC=FALSE

################################################################################
# Node Version Manager.
################################################################################

[[ -f /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh
[[ $(command -v npm) ]] && nvm_node_modules=$(npm -g root)/npm/node_modules

################################################################################
# Lynx Browser.
################################################################################

export LYNX_CFG=$HOME/.config/lynx/lynx.cfg
export LYNX_LSS=$HOME/.config/lynx/lynx.lss

################################################################################
# Functions.
################################################################################

say() {
    gtts-cli "${*}" | mpv -
}


# Unzip the file to a directory with the same file name minus .zip extension.
unzipd() {
    local name="$1"
    unzip "$name" -d "$(basename "$name" .zip)"
}

# Go to directory, open file, go to previous directory.
scratchpad() {
    cd /tmp && nvim "$@" && { cd - || exit; }
}

repo_git() {
    git --git-dir="$1" --work-tree="$2" "${@:3}"
}
repo_ui() {
    gitui -d "$1" -w "$2" "${@:3}"
}

lfcd() {
    local temporary_directory
    temporary_directory=$(mktemp)
    lf --last-dir-path "$temporary_directory" "$@"
    cd "$(cat "$temporary_directory")" || exit
    rm "$temporary_directory"
}

rangercd() {
    local temporary_directory
    temporary_directory=$(mktemp)
    ranger --choosedir="$temporary_directory" -- "${@:-$PWD}"
    cd "$(cat "$temporary_directory")" || exit
    rm "$temporary_directory"
    echo "Level ${RANGER_LEVEL:-0}"
}

joshutocd() {
    local id=$$
    mkdir -p "/tmp/$USER"
    local output_file="/tmp/$USER/joshuto-cwd-$id"
    env joshuto --output-file "$output_file" "$@"
    local exit_code=$?

    case "$exit_code" in
        # regular exit
        0) ;;
        # output contains current directory
        101) cd "$(cat "$output_file")" || exit ;;
        # output selected files
        102) ;;
        *) echo "Exit code: $exit_code" ;;
    esac
}

# Create a symlink to globally installed node modules for access to Mocha and Chai.
setup_js_scratchpad() {
    cd /tmp || exit
    if [[ ! -f package.json ]]; then
        npm init -f >/dev/null
        ln -s "$nvm_node_modules" node_modules
        ln -s ~/.config/nvim/templates/.eslintrc.yml .eslintrc.yml
        ln -s ~/.config/nvim/templates/.prettierrc.yml .prettierrc.yml
    fi
}

jsscratch() {
    setup_js_scratchpad
    nvim scratchpad.mjs "$@"
    cd - || exit
}

jsscratchtest() {
    setup_js_scratchpad
    nvim scratchpad_test.mjs "$@"
    cd - || exit
}

# Create cargo project rather than individual file.
rsscratch() {
    cd /tmp || exit
    if [[ ! -d rsscratch ]]; then
        cargo new rsscratch
    fi
    nvim /tmp/rsscratch/src/main.rs "$@"
    cd - || exit
}

dartscratch() {
    if [[ ! -f /tmp/pubspec.yaml ]]; then
        echo "name: scratchpad" > /tmp/pubspec.yaml
    fi
    scratchpad scratchpad.dart "$@"
}

# Fuzzy-find a directory and go to it.
cdf(){
    [[ -v 1 ]] && {
        cd "$1" || exit
    }
    if git rev-parse --is-inside-work-tree 2> /dev/null; then
        cd "$(find "$(git rev-parse --show-toplevel)" -type d -not -path '*/node_modules/*' -not -path '*/.git/*' | fzf)" || exit
    else
        cd "$(find ./* .config -type d | fzf)" || exit
    fi
}

################################################################################
# Aliases.
################################################################################

alias alacrittyconfig='$EDITOR ~/.config/alacritty/alacritty.toml'
alias awesomeconfig='$EDITOR ~/.config/awesome/rc.lua'
alias bashconfig='$EDITOR ~/.bashrc'
alias cppmanconfig='$EDITOR ~/.config/cppman/cppman.cfg'
alias doomconfig='$EDITOR ~/.config/doom/config.el'
alias dwlconfig='$EDITOR ~/.config/dwl/'
alias emacsconfig='$EDITOR ~/.config/doom/init.el'
alias gitconfig='$EDITOR ~/.config/git/config'
alias home-config='$EDITOR ~/.config/home-manager/home.nix'
alias hyprconfig='$EDITOR ~/.config/hypr/hyprland.conf'
alias hypridleconfig='$EDITOR ~/.config/hypr/hypridle.conf'
alias joshutoconfig='$EDITOR ~/.config/joshuto/'
alias lynxconfig='$EDITOR .config/lynx/lynx.cfg'
alias mostconfig='$EDITOR ~/.config/mostrc'
alias mpdconfig='$EDITOR ~/.config/mpd/mpd.conf'
alias mpvconfig='$EDITOR ~/.config/mpv'
alias ncmpcppconfig='$EDITOR ~/.config/ncmpcpp/'
alias neomuttconfig='$EDITOR ~/.config/mutt/'
alias neomuttmsmtpconfig='$EDITOR ~/.config/msmtp/config'
alias newsboatconfig='$EDITOR ~/.config/newsboat/'
alias nixconfig='sudo -E $EDITOR /etc/nixos/configuration.nix'
alias nuconfig='$EDITOR ~/.config/nushell/config.nu'
alias nuconfigenv='$EDITOR ~/.config/nushell/env.nu'
alias nvimconfig='$EDITOR ~/.config/nvim/init.lua'
alias nvimlspconfig='$EDITOR ~/.config/nvim/lua/plugins/lspconfig.lua'
alias nvimnullconfig='$EDITOR ~/.config/nvim/lua/plugins/null-ls.lua'
alias nvimpagerconfig='$EDITOR ~/.config/nvimpager/init.vim'
alias nvimswap='cd ~/.local/share/nvim/swap/'
alias picomconfig='$EDITOR ~/.config/picom/picom.conf'
alias qtileconfig='$EDITOR ~/.config/qtile/config.py'
alias rangercache='cd ~/.cache/ranger/'
alias rangerconfig='$EDITOR ~/.config/ranger/'
alias rifleconfig='$EDITOR ~/.config/ranger/rifle.conf'
alias roficonfig='$EDITOR ~/.config/rofi/config.rasi'
alias scopeconfig='$EDITOR ~/.config/ranger/scope.sh'
alias shellconfig='$EDITOR ~/.bash_aliases && source ~/.bash_aliases'
alias starshipconfig='$EDITOR ~/.config/starship.toml'
alias vimbconfig='$EDITOR ~/.config/vimb/config'
alias vscodiumconfig='$EDITOR ~/.config/VSCodium/User/'
alias waybarconfig='$EDITOR ~/.config/waybar/'
alias wlogoutconfig='$EDITOR ~/.config/wlogout/layout'
alias woficonfig='$EDITOR ~/.config/wofi/config'
alias zathuraconfig='$EDITOR ~/.config/zathura/zathurarc'
alias zictconfig='$EDITOR ~/.config/zict/zict.bash'
alias zshconfig='$EDITOR ~/.config/zsh/.zshrc'
alias zwimconfig='$EDITOR ~/.config/zwim/zwim.mjs'

alias passconfig='cd ~/.local/share/pass'
alias passbackup='cp -viur ~/.local/share/pass/* /run/user/1000/5bfbfc95be7243f8/primary/pass/'
alias passrefresh='kdeconnect-cli --refresh'
# alias passdiff='diff -q -r ~/.local/share/pass/ /run/user/1000/5bfbfc95be7243f8/primary/pass/'

alias awkscratch='scratchpad scratchpad.awk'
alias bashscratch='scratchpad scratchpad.bash'
alias confluencescratch='scratchpad scratchpad.confluencewiki'
alias cppscratch='scratchpad scratchpad.cpp'
alias cscratch='scratchpad scratchpad.c'
alias elscratch='scratchpad scratchpad.el'
alias groovyscratch='scratchpad scratchpad.groovy'
alias javascratch='scratchpad scratchpad.java'
alias luascratch='scratchpad scratchpad.lua'
alias mdscratch='scratchpad scratchpad.md'
alias nuscratch='scratchpad scratchpad.nu'
alias nvimscratch='scratchpad nvim-scratchpad.lua'
alias plscratch='scratchpad scratchpad.pl'
alias pyscratch='scratchpad scratchpad.py'
alias pyscratchtest='scratchpad scratchpad_test.py'
alias sagescratch='scratchpad scratchpad.sage'
alias typscratch='scratchpad scratchpad.typ'
alias zshscratch='scratchpad scratchpad.zsh'

if [[ $(command -v lsd) ]]; then
    # Show icons along with files and directories.
    alias l='lsd -lah'
    alias la='lsd -lAh'
    alias ll='lsd -lh'
    alias ls='lsd'
    alias tree='lsd --tree'
fi
if [[ $(command -v bat) ]]; then
    # Add syntax highlighting to printed files.
    alias cat='bat --style=plain --paging=never'
fi

alias dotfiles='repo_git ~/.config/dotfiles/ ~'
alias dotfilesui='repo_ui ~/.config/dotfiles/ ~ && git-summary ~/Documents -s'
alias passbgit='repo_git ~/.local/share/pass/.backup/.git ~/.local/share/pass/.backup'
alias passbgui='repo_ui ~/.local/share/pass/.backup/.git ~/.local/share/pass/.backup'

# Zict dictionary aliases.
alias ens='zict search en'
alias esb='zict search es'
alias rus='zict search ru'
alias ани='zict search en' # искать
alias руи='zict search ru' # искать

# Dictionary aliases.
alias da='sdcv --non-interactive --color'                                   # Dictionary all <word>
alias de='sdcv --non-interactive --color --use-dict --exact-search WordNet' # Dictionary exact <word>
alias di='sdcv --non-interactive --color --use-dict WordNet'                # Dictionary <word>
alias th='sdcv --non-interactive --color --use-dict "Moby Thesaurus II"'    # Thesaurus <word>

alias e='exit'
alias g='git'
alias j='joshutocd'
alias l='lfcd'
alias m='man -Hlynx'
alias n='nvim'
alias r='rangercd'
alias v='nvim'
alias в='exit'

alias alacrittyx11='WAYLAND_DISPLAY= alacritty'
alias bookmark='$EDITOR ~/Documents/Private/bookmark-browser.yaml'
alias fixtime='sudo ntpd -qg' # ntpdate -s ntp.ubuntu.com; sudo hwclock -w
alias freemusic='mpv ~/Music/chosic.com -shuffle -no-video'
alias gdiff='git fetch && git diff origin/master HEAD'
alias lf='$HOME/Code/lfimg/lfrun'
alias locksway='swaylock -i /usr/share/backgrounds/suckless-wallpapers/nord_hills.png'
alias lockx='xscreensaver-command -lock'
alias man='man -a'
alias mpvh='mpv --config-dir="$HOME/.config/mpv/base"'
alias nr='setsid --fork alacritty -e ranger'
alias nt='setsid --fork alacritty'
alias nullls='cd $HOME/.local/share/nvim/lazy/null-ls.nvim/lua/null-ls/builtins'
alias playmusic='mpv --shuffle ~/Music/*'
alias rgf='rg --files | rg'
alias rsyncdelete='rsync -arv --delete'
alias rsyncdryrun='rsync -arvn --delete'
alias y='yt-dlp --write-thumbnail --extract-audio --sub-langs "en.*,ja,es,ru" --write-subs --audio-format mp3 --paths ~/Music/YouTube'
alias yd='yt-dlp --write-thumbnail --extract-audio --sub-langs "en.*,ja,es,ru" --write-subs --audio-format mp3 --paths'
alias zathurah='zathura --config-dir="$HOME/.config/zathura/base"'

alias nixadd='nix derivation add'
alias nixedit='nix edit -f "<nixpkgs>"'
alias nixrepl='nix repl --file "<nixpkgs/nixos>" -I nixos-config=/etc/nixos/configuration.nix'
alias nixsearch='nix search nixpkgs --extra-experimental-features flakes'
alias nixshow='nix derivation show'

# XDG-Ninja.
alias wget=wget --hsts-file='$XDG_DATA_HOME/wget-hsts'

# shellcheck source=./.my_aliases
[[ -f ~/.my_aliases ]] && source ~/.my_aliases
