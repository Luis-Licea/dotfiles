# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|alacritty) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
###################################################################
# WSL Directory Aliases.
###################################################################
## Go to home folder.
#alias homef='cd /mnt/c/Users/luisl/'
## Go to d drive folder.
#alias df='cd /mnt/d/'
## Go to Qt folder.
#alias qtf='cd /mnt/d/Documents/Qt/'
## Go to Downloads folder.
#alias downf='cd /mnt/d/Downloads/'
## Go to Code folder.
#alias codef='cd /mnt/d/Downloads/Code'
## Go to temp folder in d.
#alias tempf='cd /mnt/d/Downloads/Temp/'
## Go to LaTeX folder.
#alias latexf='cd /mnt/d/Documents/LaTeX/'
## Go to Documents folder.
#alias docf='cd /mnt/d/Documents/'j
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
####################################################################
# Terminal Aliases.
###################################################################
# Make a shorter alias for exit command.
alias e='exit'
# Make a shorter alias for cheat.sh.
alias c='cht.sh'
# Make a shorter alias for cheat.sh --shell command.
alias cs='cht.sh --shell'
###################################################################
# Tmux startup customization.
###################################################################
# Enable or disable tmux at startup.
is_tmux_enabled=false
# Whether or not to load tmux configurations.
if $is_tmux_enabled ; then
    # Make a shorter alias for tmux.
    alias t='tmux'
    # Make a shorter alias to kill all the other sessions.
    alias tka='tmux kill-session -a'
    # Update tmux source file at startup.
    tmux source-file ~/.tmux.conf
    # Run tmux at startup and test that (1) tmux exists on the system, (2) it
    # is in an interactive shell, and (3) tmux doesn't try to run within
    # itself.
    if command -v tmux &> /dev/null \
        && [ -n "$PS1" ] \
        && [[ ! "$TERM" =~ screen ]] \
        && [[ ! "$TERM" =~ tmux ]] \
        && [ -z "$TMUX" ]; then
        # Find the terminal name. Could be alacritty, konsole, etc.
        current_terminal=$(ps -o 'cmd=' -p "$(ps -o 'ppid=' -p $$)")
        # Match the current terminal path to any string ending with "alacritty".
        # This is useful so that tmux only runs inside alacritty.
        if [[ $current_terminal == *"alacritty" ]]; then
            # Attach tmux if a session exists, otherwise run tmux.
            tmux attach || exec tmux
        fi
    fi
fi
###################################################################
# Vim settings.
###################################################################
# Set vi mode in terminal.
set -o vi
# Make a shorter alias for vim.
alias v='vim'
###################################################################
# Other settings.
###################################################################
## Change the starting directory of WSL in Windows 10.
#if [ "/mnt/c/WINDOWS/system32" == "$PWD"  ]; then
#  # Go to home directory or return if command fails.
#  cd ~/ || return
#fi
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
## This line was automatically added by installing Rustup.
#source "$HOME/.cargo/env"
###################################################################
# Python CLI tools.
###################################################################
export PATH=/home/luis/.local/bin/:$PATH
