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
alias g="git status"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gpl="git pull --ff-only"
alias gpo="git push origin"
alias gtree="git log --graph --decorate --oneline --all"
alias gka="gitk --all &"
alias gd="git diff"
alias gb="git branch"
alias gl="git log --decorate --oneline"
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gst="git stash"
alias gi="git init"

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
