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
sudo yum update && \
sudo yum -y groupinstall "Development tools" && \
sudo yum -y install \
  autoconf \
  automake \
  curl \
  git-all \
  pcre-devel \
  python \
  rubygems \
  tmux \
  wget \
  xz-devel \
  zlib-devel \
  zsh

# Change login shell from bash to zsh
sudo chsh -s $(which zsh) $(whoami)

# Download silver searcher
if ! [ -d "$SRC_DIRECTORY/the_silver_searcher" ]; then
  cd $SRC_DIRECTORY
  sudo git clone https://github.com/ggreer/the_silver_searcher.git
  cd the_silver_searcher
  sudo ./build.sh
  sudo make install
fi

tput setaf 2; echo '>> Package installation complete!'

tput setaf 3; echo '>> Setup Dropbox'
# Source: http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-centos-gui-required
if ! [ -d $DROPBOX ]; then
  # Download Dropbox for 64-bit CentOS system
  cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

  # Run the dropboxd application
  ~/.dropbox-dist/dropboxd

  # Download Dropbox CLI interface
  mkdir -p ~/bin && wget -O ~/bin/dropbox.py "https://www.dropbox.com/download?dl=packages/dropbox.py" && chmod +x ~/bin/dropbox.py

  # Turn on Dropbox
  ~/bin/dropbox.py start

  # prevent lan broadcasting
  ~/bin/dropbox.py lansync n

  # Exclude everything in dropbox, then whitelist certain folders/files
  cd ~/Dropbox && ~/bin/dropbox.py exclude add * && \
    ~/bin/dropbox.py exclude remove my-wiki setup todo.md

  # Turn off Dropbox sync
  ~/bin/dropbox.py stop

  # Setup Dropbox symlinks
  ln -sf $DROPBOX/my-wiki $HOME/my-wiki
  ln -sf $DROPBOX/setup/bash_profile.work $HOME/.bash_profile.work
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
  ln -sf $DOTFILES/vim/colors $HOME/.vim/colors
  ln -sf $DOTFILES/zsh/zshrc $HOME/.zshrc
  ln -sf $DOTFILES/zsh/async.zsh $HOME/.async.zsh
  ln -sf $DOTFILES/zsh/pure.zsh $HOME/.pure.zsh

 tput setaf 2; echo '>> Dropbox installation complete!'
else
 tput setaf 1; echo '>> Dotfiles was already setup.'
fi

# Enter zsh shell
zsh

# Download tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# Download and install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

tput setaf 2; echo '>> LINUX SETUP COMPLETE!'
