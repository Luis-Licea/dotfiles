# dotfiles
A backup repository for storing configuration files.

Clone the repo into a 'dotfiles' directory:
```bash
git clone --bare https://github.com/Luis-Licea/dotfiles $HOME/.config/dotfiles/
```

Define the aliases in bashrc or zshrc to access repo from anywhere:
```bash
alias dotfiles="/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME"
alias dotfilesui="gitui -d $HOME/.config/dotfiles/ -w $HOME"
```

Checkout the content from the bare repository to '$HOME':
```bash
dotfiles checkout
```

View tracked files and changes that need to be committed:
```bash
dotfilesui
```
