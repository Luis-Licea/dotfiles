#!/usr/bin/env bash

dotfiles=(
    .zshrc
    .p10k.zsh
    .mostrc
    .latexmkrc
    .gitconfig
    .config/VSCodium/User/keybindings.json
    .config/VSCodium/User/settings.json
    .config/ranger/commands_full.py
    .config/ranger/commands.py
    .config/ranger/rc.conf
    .config/ranger/rifle.conf
    .config/ranger/scope.sh
    .config/nvim/init.vim
    .config/alacritty/alacritty.yml
)

# Iterate thru every dotfile.
for dotfile in "${dotfiles[@]}"; do
    # Store differences between the files.
    differences=$(diff "$dotfile" "$HOME/$dotfile")

    # If file already exists and the files are not different:
    if [ -f "$HOME/$dotfile" ] && ! [ "$differences" ]; then
        echo "$dotfile exists and is up to date."

        # Create soft link; ask before replacing existing file.
        ln --interactive "$dotfile" "$HOME/$dotfile"
        echo "$HOME/$dotfile link set."

    elif [ "$differences" ]; then
        echo "$dotfile exists, but incoming file (top) differs from exising one (bottom):"
        echo "$differences"
    fi
done
