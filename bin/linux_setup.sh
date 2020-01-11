#!/bin/bash

# Set up Linux environment. Run this on a fresh Linux virtual machine after cloning the codebase.

# Exit if any subcommand fails
set -e

# Define variables
DOTFILES="$HOME/.dotfiles"
SRC_DIRECTORY="/usr/local/src"
DROPBOX="$HOME/Dropbox"

tput setaf 3; echo '>> Installing packages'
# Download all packages necessary for development
sudo pacman -Syu && \
sudo pacman -S \
  curl \
  git \
  htop \
  the_silver_searcher \
  tmux \
  vim \
  xclip \
  zsh

tput setaf 2; echo '>> Package installation complete!'

tput setaf 3; echo '>> Setup Dropbox'
if ! [ -d $DROPBOX ]; then
  # Get dropbox from arch repo - https://aur.archlinux.org/packages/dropbox/
  git clone https://aur.archlinux.org/dropbox.git ~/Downloads && cd ~/Downloads/dropbox && makepkg -si

  # Setup Dropbox symlinks
  ln -sf $DROPBOX/my-wiki $HOME/my-wiki
  ln -sf $DROPBOX/todo.md $HOME/todo.md

  tput setaf 2; echo '>> Dropbox installation complete!'
else
 tput setaf 1; echo '>> Dropbox was already setup.'
fi

tput setaf 3; echo '>> Setup dotfiles'
if ! [ -d $DOTFILES ]; then
  # Copy over dotfiles
  mv $HOME/dotfiles $DOTFILES

  # Download vundle for vim plugins
  if ! [ -d $HOME/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi

  # Setup symlinks
  ln -sf $DOTFILES/ag/agignore $HOME/.agignore
  ln -sf $DOTFILES/git/gitprompt $HOME/.gitprompt
  ln -sf $DOTFILES/git/gitignore_global $HOME/.gitignore_global
  ln -sf $DOTFILES/git/gitconfig $HOME/.gitconfig
  ln -sf $DOTFILES/git/gitmessage $HOME/.gitmessage
  ln -sf $DOTFILES/go/golangrc $HOME/.golangrc
  sudo ln -sf $DOTFILES/tmux/tat /usr/local/bin/tat && chmod +x $DOTFILES/tmux/tat
  ln -sf $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
  ln -sf $DOTFILES/vim/vimrc $HOME/.vimrc
  ln -sf $DOTFILES/vim/colors $HOME/.vim
  ln -sf $DOTFILES/zsh/zshrc $HOME/.zshrc
  ln -sf $DOTFILES/zsh/zshrc.home $HOME/.zshrc.home
  ln -sf $DOTFILES/zsh/async.zsh $HOME/.async.zsh
  ln -sf $DOTFILES/zsh/pure.zsh $HOME/.pure.zsh
  mkdir -p $HOME/.zsh && ln -sf $DOTFILES/zsh/functions $HOME/.zsh/

 tput setaf 2; echo '>> Dotfiles installation complete!'
else
 tput setaf 1; echo '>> Dotfiles was already setup.'
fi

# Download tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# Download and install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Download and install nvm
mkdir ~/.nvm && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

# Download solarized dark theme for terminal
# Arch Repo: https://aur.archlinux.org/packages/solarized-dark-themes/
git clone https://aur.archlinux.org/solarized-dark-themes.git ~/Downloads && cd ~/Downloads/solarized-dark-themes && makepkg -si

# Change login shell from bash to zsh
sudo chsh -s $(which zsh) $(whoami)

# Enter zsh shell
zsh

tput setaf 2; echo '>> LINUX SETUP COMPLETE!'
