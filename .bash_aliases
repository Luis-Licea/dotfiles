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

# Disable loading Ranger's global configuration files because custom
# configurations are provided.
export RANGER_LOAD_DEFAULT_RC=FALSE

################################################################################
# NVM.
################################################################################
# Node Version Manager.
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
[ -n "$NVM_BIN" ] && nvm_node_modules="${NVM_BIN%/bin}/lib/node_modules"

################################################################################
# Lynx Browser.
################################################################################
export LYNX_CFG="$HOME/.config/lynx/lynx.cfg"
export LYNX_LSS="$HOME/.config/lynx/lynx.lss"

################################################################################
# Aliases.
################################################################################

# Suffix aliases.
alias -s {md,txt}='$EDITOR'

# Stay in current folder when exiting ranger. Show ranger nested level at exit.
alias ranger='source ranger && echo "Level ${RANGER_LEVEL:-0}"'

alias alacrittyconfig='$EDITOR ~/.config/alacritty/alacritty.yml'
alias awesomeconfig='$EDITOR ~/.config/awesome/rc.lua'
alias cppmanconfig='$EDITOR ~/.config/cppman/cppman.cfg'
alias dwlconfig='$EDITOR ~/.config/dwl/'
alias gitconfig='$EDITOR ~/.config/git/config'
alias lynxconfig='$EDITOR .config/lynx/lynx.cfg'
alias mostconfig='$EDITOR ~/.config/mostrc'
alias mpdconfig='$EDITOR ~/.config/mpd/mpd.conf'
alias mpvconfig='$EDITOR ~/.config/mpv'
alias ncmpcppconfig='$EDITOR ~/.config/ncmpcpp/'
alias neomuttconfig='$EDITOR ~/.config/mutt/'
alias neomuttmsmtpconfig='$EDITOR ~/.config/msmtp/config'
alias newsboatconfig='$EDITOR ~/.config/newsboat/'
alias nvimconfig='$EDITOR ~/.config/nvim/init.lua'
alias nvimpagerconfig='$EDITOR ~/.config/nvimpager/init.vim'
alias nvimswap='cd ~/.local/share/nvim/swap/'
alias picomconfig='$EDITOR ~/.config/picom/picom.conf'
alias rangercache='cd ~/.cache/ranger/'
alias rangerconfig='$EDITOR ~/.config/ranger/'
alias roficonfig='$EDITOR ~/.config/rofi/config.rasi'
alias shellconfig='$EDITOR ~/.bash_aliases'
alias vimbconfig='$EDITOR ~/.config/vimb/config'
alias vscodiumconfig='$EDITOR ~/.config/VSCodium/User/'
alias waybarconfig='$EDITOR ~/.config/waybar/'
alias zathuraconfig='$EDITOR ~/.config/zathura/zathurarc'
alias zshconfig='$EDITOR ~/.zshrc'

alias passconfig='cd ~/.local/share/pass'
alias passbackup='cp -iur ~/.local/share/pass/* /run/user/1000/5bfbfc95be7243f8/primary/pass/'
alias passdiff='kdeconnect-cli --refresh && diff -q ~/.local/share/pass/ /run/user/1000/5bfbfc95be7243f8/primary/pass/'

scratchpad() {
    # Go to directory, open file, go to previous directory.
    cd /tmp && nvim "$1" && cd -
}

alias awkscratch='scratchpad scratchpad.awk'
alias bashscratch='scratchpad scratchpad.sh'
alias confluencescratch='scratchpad scratchpad.confluencewiki'
alias cppscratch='scratchpad scratchpad.cpp'
alias cscratch='scratchpad scratchpad.c'
alias groovyscratch='scratchpad scratchpad.groovy'
alias luascratch='scratchpad scratchpad.lua'
alias mdscratch='scratchpad scratchpad.md'
alias pyscratch='scratchpad scratchpad.py'
alias pyscratchtest='scratchpad scratchpad_test.py'
alias todoscratch='scratchpad todo.md'
alias todo='$EDITOR "$HOME/To Do.md"'
alias txtscratch='scratchpad scratchpad.txt'

# Create a symlink to globally installed node modules for access to Mocha and Chai.
alias jsscratch='cd /tmp && [ ! -f package.json ] && npm init -f > /dev/null && ln -s "$nvm_node_modules" node_modules && ln -s ~/.config/nvim/templates/.eslintrc.yml .eslintrc.yml && ln -s ~/.config/nvim/templates/.prettierrc.yml .prettierrc.yml && nvim scratchpad.mjs || nvim scratchpad.mjs && cd -'
alias jsscratchtest='cd /tmp && [ ! -f package.json ] && npm init -f > /dev/null && ln -s "$nvm_node_modules" node_modules && ln -s ~/.config/nvim/templates/.eslintrc.yml .eslintrc.yml && ln -s ~/.config/nvim/templates/.prettierrc.yml .prettierrc.yml && nvim scratchpad_test.mjs || nvim scratchpad_test.mjs && cd -'
# Create cargo project rather than individual file.
alias rsscratch='cd /tmp && [ ! -d rsscratch ] && cargo new rsscratch && nvim rsscratch/src/main.rs || nvim /tmp/rsscratch/src/main.rs && cd -'

scratchpad() { cd /tmp && nvim "$@" && cd -; }
repo_git() { git --git-dir="$1" --work-tree="$2" "${@:3}"; }
repo_ui() { gitui --polling -d "$1" -w "$2" "${@:3}"; }

alias dotfiles='repo_git ~/.config/dotfiles/ ~'
alias dotfilesui='repo_ui ~/.config/dotfiles/ ~ && git-summary ~/Code -s'
alias passbgit='repo_git ~/.local/share/pass/.backup/.git ~/.local/share/pass/.backup'
alias passbgui='repo_ui ~/.local/share/pass/.backup/.git ~/.local/share/pass/.backup'

alias d='sdcv -u WordNet'
alias de='sdcv -eu WordNet'
alias e='exit'
alias m='man -Hlynx'
alias nr='setsid --fork alacritty -e ranger'
alias nt='setsid --fork alacritty'
alias r='ranger'
alias t="sdcv -u 'Moby Thesaurus II'"
alias v='nvim'

alias cheat='cht.sh'
alias locksway='swaylock -i /usr/share/backgrounds/suckless-wallpapers/nord_hills.png'
alias lockx='xscreensaver-command -lock'
alias mpvh='mpv --config-dir="$HOME/.config/mpv/base"'
alias playmusic='mpv /run/media/luis/DATA/Music/* --shuffle'
alias sqlite-doc='xdg-open /usr/share/doc/sqlite/doclist.html'
alias zathurah='zathura --config-dir="$HOME/.config/zathura/base"'

export bgs='/usr/share/backgrounds/nordic-wallpapers/'

# Only enter SSH password once.
# keychain --quiet --eval id_rsa > /dev/null

# shellcheck source=./.my_aliases
[[ -f ~/.my_aliases ]] && source ~/.my_aliases
