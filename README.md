# dotfiles

A backup repository for storing configuration files.

Clone the repo into a 'dotfiles' directory:

```bash
git clone --bare https://github.com/Luis-Licea/dotfiles $HOME/.config/dotfiles/ --recurse-submodules
```

Define the aliases in .bashrc or .zshrc to access repo from anywhere:

```bash
alias dotfiles="/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME"
dotfiles config --local status.showUntrackedFiles no
alias dotfilesui="gitui -d $HOME/.config/dotfiles/ -w $HOME"
```

A token is necessary for pushing changes.

```sh
dotfiles push -u origin master
# Username: <type your username>
# Password: <type your password or personal access token (GitHub)>
```

Check Git configurations.

```sh
git config -l
```

Checkout the content from the bare repository to '$HOME':

```bash
dotfiles checkout
```

View tracked files and changes that need to be committed:

```bash
dotfilesui
```

## Backup Checklist
- Export GPG keys.
- Backup $GNUHOME.
- Backup /home/<user> directory.
- Backup databases if any.
- Backup /etc folder.
