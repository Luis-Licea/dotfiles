# Lines configured by zsh-newuser-install
################################################################################
# History settings.
################################################################################
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Automatically cd into directories without using cd, and other things.
setopt autocd extendedglob nomatch notify

# Do not make beeping sounds.
unsetopt beep

# Do not keep duplicate commands in history
setopt HIST_IGNORE_ALL_DUPS

# Do not remember commands that start with a white space.
setopt HIST_IGNORE_SPACE
################################################################################
# Enable vi mode.
################################################################################
# Enable vi mode.
bindkey -v

# Enable backspace.
bindkey -v '^?' backward-delete-char

## Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load compinit. -U means autoload and suppress alias expansion; -z means use zsh.
autoload -Uz compinit

# Run compinit to bind tab key to complete-word.
compinit
################################################################################
# Basic auto/tab complete:
################################################################################
# Tab to correct spelling errors and approximate closest choice.
#zstyle ':completion:*' completer _complete _correct _approximate

# Double tab allows you to move in the tab completion menu.
zstyle ':completion:*' menu select
zmodload zsh/complist

# Use vim keys in tab completion menu instead of arrow keys.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Include hidden files in completion menu.
_comp_options+=(globdots)

# Correct spelling of all arguments in the command line
# setopt CORRECT_ALL
################################################################################
# Enable colors and change default prompt.
################################################################################
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
################################################################################
# Load zsh-syntax-highlighting; should be last.
################################################################################
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
################################################################################
# Luke's config for the Zoomer Shell
################################################################################
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}
###################################################################
# Tmux startup customization.
###################################################################
# Make a shorter alias for tmux.
alias t='tmux'
# Make a shorter alias to kill all the other sessions.
alias tka='tmux kill-session -a'
# Update tmux source file at startup.
tmux source-file ~/.tmux.conf
# Run tmux at startup and test that (1) tmux exists on the system, (2) it is in an interactive shell, and (3) tmux doesn't try to run within itself.
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    # Find the terminal name. Could be alacritty, konsole, gnome-terminal, etc.
    current_terminal=$(ps -o 'cmd=' -p "$(ps -o 'ppid=' -p $$)")
    # Match the current terminal path to any string ending with "alacritty".
    # This is useful so that tmux only runs inside alacritty.
    if [[ $current_terminal == *"alacritty" ]]; then
        # Attach tmux if a session exists, otherwise run tmux.
        tmux attach || exec tmux
    fi
fi
###################################################################
# Ranger settings.
###################################################################
# Prevent nested ranger instances.
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}
# Stay in current folder when exiting ranger.
alias ranger='source ranger'
################################################################################
# Other settings.
################################################################################
## Load aliases and shortcuts if existent.
#[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
#[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
####################################################################
# Directory Aliases.
###################################################################
# Go to home folder.
alias homef='cd ~/'
# Go to Qt folder.
alias qtf='cd ~/Documents/Qt/'
# Go to Downloads folder.
alias downf='cd ~/Downloads/'
# Go to Code folder.
alias codef='cd ~/Documents/Code'
# Go to temp folder in d.
alias tempf='cd ~/Downloads/Temp/'
# Go to LaTeX folder.
alias latexf='cd ~/Documents/LaTeX/'
# Go to Documents folder.
alias docf='cd ~/Documents/'
# Go to Pictures folder.
alias picf='cd ~/Pictures/'
# Go to Music folder.
alias musicf='cd ~/Music/'
# Go to Templates folder.
alias templatef='cd ~/Templates/'
# Go to Videos folder.
alias videof='cd ~/Videos/'
# Go to library folder.
alias libf='cd ~/Documents/Calibre\ Library/'
####################################################################
# Directory Aliases for DATA drive.
###################################################################
# Mount DATA drive.
alias mountd='udisksctl mount -b /dev/sdb1'
# Go to home folder.
alias homed='cd /run/media/luis/DATA/'
# Go to Qt folder.
alias qtd='cd /run/media/luis/DATA/Documents/Qt/'
# Go to Downloads folder.
alias downd='cd /run/media/luis/DATA/Downloads/'
# Go to Code folder.
alias coded='cd /run/media/luis/DATA/Documents/Code'
# Go to temp folder in d.
alias tempd='cd /run/media/luis/DATA/Downloads/Temp/'
# Go to LaTeX folder.
alias latexd='cd /run/media/luis/DATA/Documents/LaTeX/'
# Go to Documents folder.
alias docd='cd /run/media/luis/DATA/Documents/'
# Go to Pictures folder.
alias picd='cd /run/media/luis/DATA/Pictures/'
# Go to Music folder.
alias musicd='cd /run/media/luis/DATA/Music/'
# Go to Templates folder.
alias templated='cd /run/media/luis/DATA/Templates/'
# Go to Videos folder.
alias videod='cd /run/media/luis/DATA/Videos/'
# Go to library folder.
alias libd='cd /run/media/luis/DATA/Documents/Calibre\ Library/'

alias javad='cd /run/media/luis/DATA/Documents/College/5\ Senior/Fall/FA21\ 15W\ CSCI4316.01\ Adv.\ Enterprise\ Java\ \&\ Framewk/'
alias networkd='cd /run/media/luis/DATA/Documents/College/5\ Senior/Fall/FA21\ 15W\ CSCI4312.01\ Network\ Protocols/'
alias operatingd='cd /run/media/luis/DATA/Documents/College/5\ Senior/Fall/FA21\ 15W\ CSCI4354.01\ Operating\ Systems/'
####################################################################
# Terminal Aliases.
###################################################################
# Make a shorter alias for exit command.
alias e='exit'
# Make a shorter alias for vim.
alias v='vim'
################################################################################
# Add autojump.
################################################################################
export AUTOJUMP_SOURCED=1

# set user installation paths
if [[ -d ~/.autojump/bin ]]; then
    path=(~/.autojump/bin ${path})
fi
if [[ -d ~/.autojump/functions ]]; then
    fpath=(~/.autojump/functions ${fpath})
fi


# set homebrew installation paths
if command -v brew &>/dev/null; then
  local brew_prefix=${BREW_PREFIX:-$(brew --prefix)}
  if [[ -d "${brew_prefix}/share/zsh/site-functions" ]]; then
    fpath=("${brew_prefix}/share/zsh/site-functions" ${fpath})
  fi
fi


# set error file location
if [[ "$(uname)" == "Darwin" ]]; then
    export AUTOJUMP_ERROR_PATH=~/Library/autojump/errors.log
elif [[ -n "${XDG_DATA_HOME}" ]]; then
    export AUTOJUMP_ERROR_PATH="${XDG_DATA_HOME}/autojump/errors.log"
else
    export AUTOJUMP_ERROR_PATH=~/.local/share/autojump/errors.log
fi

if [[ ! -d ${AUTOJUMP_ERROR_PATH:h} ]]; then
    mkdir -p ${AUTOJUMP_ERROR_PATH:h}
fi


# change pwd hook
autojump_chpwd() {
    if [[ -f "${AUTOJUMP_ERROR_PATH}" ]]; then
        autojump --add "$(pwd)" >/dev/null 2>>${AUTOJUMP_ERROR_PATH} &!
    else
        autojump --add "$(pwd)" >/dev/null &!
    fi
}

typeset -gaU chpwd_functions
chpwd_functions+=autojump_chpwd


# default autojump command
j() {
    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        autojump ${@}
        return
    fi

    setopt localoptions noautonamedirs
    local output="$(autojump ${@})"
    if [[ -d "${output}" ]]; then
        if [ -t 1 ]; then  # if stdout is a terminal, use colors
                echo -e "\\033[31m${output}\\033[0m"
        else
                echo -e "${output}"
        fi
        cd "${output}"
    else
        echo "autojump: directory '${@}' not found"
        echo "\n${output}\n"
        echo "Try \`autojump --help\` for more information."
        false
    fi
}


# jump to child directory (subdirectory of current path)
jc() {
    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        autojump ${@}
        return
    else
        j $(pwd) ${@}
    fi
}


# open autojump results in file browser
jo() {
    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        autojump ${@}
        return
    fi

    setopt localoptions noautonamedirs
    local output="$(autojump ${@})"
    if [[ -d "${output}" ]]; then
        case ${OSTYPE} in
            linux*)
                xdg-open "${output}"
                ;;
            darwin*)
                open "${output}"
                ;;
            cygwin)
                cygstart "" $(cygpath -w -a ${output})
                ;;
            *)
                echo "Unknown operating system: ${OSTYPE}" 1>&2
                ;;
        esac
    else
        echo "autojump: directory '${@}' not found"
        echo "\n${output}\n"
        echo "Try \`autojump --help\` for more information."
        false
    fi
}


# open autojump results (child directory) in file browser
jco() {
    if [[ ${1} == -* ]] && [[ ${1} != "--" ]]; then
        autojump ${@}
        return
    else
        jo $(pwd) ${@}
    fi
}
