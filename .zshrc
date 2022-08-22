# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Set powerlevel10k as theme if installed, and set agnoster theme as a backup.
POWERLEVEL10k_DIR=zsh-theme-powerlevel10k
if [[ "$TERM" == "linux" ]]; then
    # If using the tty, load a simple theme.
    ZSH_THEME="half-life"
elif [[ -d "$ZSH../$POWERLEVEL10k_DIR" ]] && [[ "$TERM" != "linux" ]]; then
    # Must be a path relative to themes folder in $ZSH folder.
    ZSH_THEME=../../$POWERLEVEL10k_DIR/powerlevel10k
else
    # Backup theme.
    ZSH_THEME="agnoster"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode copypath copyfile)


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Disable loading Ranger's global configuration files.
export RANGER_LOAD_DEFAULT_RC=FALSE

# Stay in current folder when exiting ranger. Show ranger nested level at exit.
alias ranger='source ranger && echo "Level ${RANGER_LEVEL:-0}"'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR=nvim
else
  export PAGER=nvimpager
  export EDITOR=nvim
  alias vim='nvim --noplugin'
  alias edit=$EDITOR
  alias page=$PAGER
fi
export VISUAL="$EDITOR"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias nvimconfig="$EDITOR ~/.config/nvim/init.vim"
alias nvimswap="cd ~/.local/share/nvim/swap/"
alias alacrittyconfig="$EDITOR ~/.config/alacritty/alacritty.yml"
alias rangerconfig="$EDITOR ~/.config/ranger/"
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

alias cppscratch="cd /tmp && nvim scratchpad.cpp && cd -"
alias rsscratch="cargo new /tmp/rsscratch & cd /tmp/rsscratch && nvim . && cd -"
alias pyscratch="cd /tmp && nvim scratchpad.py && cd -"
alias bashscratch="cd /tmp && nvim scratchpad.sh && cd -"
alias txtscratch="cd /tmp && nvim scratchpad.txt && cd -"

alias dotfiles="/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME"
alias dotfilesui="gitui -d $HOME/.config/dotfiles/ -w $HOME"
alias passbgit="git --git-dir="$HOME/.local/share/pass/.backup/.git" \
    --work-tree="$HOME/.local/share/pass/.backup""
alias passbgui="gitui -d "$HOME/.local/share/pass/.backup/.git" \
    -w "$HOME/.local/share/pass/.backup""

alias e='exit'
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

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
