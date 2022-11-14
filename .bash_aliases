#!/usr/bin/env bash

################################################################################
# Preferred editor for local and remote sessions
################################################################################
if [[ -n $SSH_CONNECTION ]]; then
    if [[ -x "$(command -v nvim)" ]]; then
        export EDITOR=nvim
    elif [[ -x "$(command -v vim)" ]]; then
        export EDITOR=vim
    elif [[ -x "$(command -v vi)" ]]; then
        export EDITOR=vi
    fi
fi

if [[ -x "$(command -v nvimpager)" ]]; then
    export PAGER=nvimpager
elif [[ -x "$(command -v most)" ]]; then
    export PAGER=most
fi

export EDITOR=nvim
export VISUAL="$EDITOR"
alias ema='emacsclient --create-frame'
alias em='setsid --fork emacsclient --create-frame && exit'

################################################################################
# Aliases.
################################################################################

# Disable loading Ranger's global configuration files because custom
# configurations are provided.
export RANGER_LOAD_DEFAULT_RC=FALSE

# Stay in current folder when exiting ranger. Show ranger nested level at exit.
alias ranger='source ranger && echo "Level ${RANGER_LEVEL:-0}"'

alias shellconfig="$EDITOR ~/.bash_aliases"
alias zshconfig="$EDITOR ~/.zshrc"
alias awesomeconfig="$EDITOR ~/.config/awesome/rc.lua"
alias nvimconfig="$EDITOR ~/.config/nvim/init.lua"
alias nvimswap="cd ~/.local/share/nvim/swap/"
alias alacrittyconfig="$EDITOR ~/.config/alacritty/alacritty.yml"
alias rangerconfig="$EDITOR ~/.config/ranger/"
alias rangercache="cd ~/.cache/ranger/"
alias vscodiumconfig="$EDITOR ~/.config/VSCodium/User/"
alias picomconfig="$EDITOR ~/.config/picom/picom.conf"
alias mostconfig="$EDITOR ~/.config/mostrc"
alias vimbconfig="$EDITOR ~/.config/vimb/config"
alias newsboatconfig="$EDITOR ~/.config/newsboat/"
alias nvimpagerconfig="$EDITOR ~/.config/nvimpager/init.vim"
alias mpdconfig="$EDITOR ~/.config/mpd/mpd.conf"
alias ncmpcppconfig="$EDITOR ~/.config/ncmpcpp/"
alias zathuraconfig="$EDITOR ~/.config/zathura/zathurarc"
alias cppmanconfig="$EDITOR ~/.config/cppman/cppman.cfg"
alias neomuttconfig="$EDITOR ~/.config/mutt/"
alias neomuttmsmtpconfig="$EDITOR ~/.config/msmtp/config"
alias waybarconfig="$EDITOR ~/.config/waybar/"
alias dwlconfig="$EDITOR ~/.config/dwl/"
alias gitconfig="$EDITOR ~/.config/git/config"

alias passconfig="cd ~/.local/share/pass"
alias passbackup="cp -iur ~/.local/share/pass/* /run/user/1000/5bfbfc95be7243f8/primary/pass/"
alias passdiff="kdeconnect-cli --refresh && diff -q ~/.local/share/pass/ /run/user/1000/5bfbfc95be7243f8/primary/pass/"

alias bashscratch="cd /tmp && nvim scratchpad.sh && cd -"
alias cppscratch="cd /tmp && nvim scratchpad.cpp && cd -"
alias cscratch="cd /tmp && nvim scratchpad.c && cd -"
# Create a symlink to globally installed node modules for access to Mocha and Chai.
alias jsscratch="cd /tmp && [ ! -f package.json ] && npm init -f > /dev/null && ln -s /usr/lib/node_modules/ node_modules && ln -s ~/.config/nvim/templates/.eslintrc.yml .eslintrc.yml && nvim scratchpad.mjs || nvim scratchpad.mjs && cd -"
alias mochascratch="cd /tmp && [ ! -f package.json ] && npm init -f > /dev/null && ln -s /usr/lib/node_modules/ node_modules && ln -s ~/.config/nvim/templates/.eslintrc.yml .eslintrc.yml && nvim mocha.mjs || nvim mocha.mjs && cd -"
alias luascratch="cd /tmp && nvim scratchpad.lua && cd -"
alias pyscratch="cd /tmp && nvim scratchpad.py && cd -"
alias rsscratch="cd /tmp && [ ! -d rsscratch ] && cargo new rsscratch && nvim rsscratch/src/main.rs || nvim /tmp/rsscratch/src/main.rs && cd -"
alias txtscratch="cd /tmp && nvim scratchpad.txt && cd -"
alias groovyscratch="cd /tmp && nvim scratchpad.groovy && cd -"

alias dotfiles="/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME"
alias dotfilesui="gitui -d $HOME/.config/dotfiles/ -w $HOME"
alias passbgit="git --git-dir="$HOME/.local/share/pass/.backup/.git" \
    --work-tree="$HOME/.local/share/pass/.backup""
alias passbgui="gitui -d "$HOME/.local/share/pass/.backup/.git" \
    -w "$HOME/.local/share/pass/.backup""

alias e='exit'
alias v='nvim'
alias h='helix'
alias r='ranger'
alias c='codium .'
alias d='sdcv -u WordNet'
alias de='sdcv -eu WordNet'
alias t="sdcv -u 'Moby Thesaurus II'"
alias n='setsid --fork alacritty &'
alias cheat='cht.sh'
alias swaylock='swaylock -i /usr/share/backgrounds/suckless-wallpapers/nord_hills.png'
alias playmusic='setsid -f mpv /run/media/luis/DATA/Music/* --shuffle'
export bgs='/usr/share/backgrounds/nordic-wallpapers/'

# Only enter SSH password once.
# keychain --quiet --eval id_rsa > /dev/null
