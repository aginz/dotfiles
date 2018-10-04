#Rails Alias
alias r="rails"
alias s="server"
alias b="bundle"
alias be="bundle exec"

#VIM Alias
alias v="vim"
alias vi="vim"

#TMUX Alias
alias ta="tmux attach"

#Git Alias
alias g="git"

#Bash Alias
alias ls="ls -FGAlh"

# Constants
OS_PATH=

if [[ $OS == "Darwin" ]]; then
  OS_PATH="~"
else
  OS_PATH="/mnt/c/Users/leona"
fi

# Set Navigation Aliases
alias gocode="cd $OS_PATH/code"
alias gowork="cd $OS_PATH/code"
alias dot="cd $HOME/.dotfiles"
