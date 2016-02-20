
#include golangrc
source ~/.golangrc

#include gitprompt for terminal
source ~/.gitprompt

#Sass Alias
alias swm="sass --watch style/main.scss:css/main.css"
alias sw="sass --watch"

#Rails Alias
alias rs="rails s"

#Nginx Alias for localhost:3000 / Legacy
alias seelog="tail -f log/development.log"
alias restart="touch tmp/restart.txt"

#VIM Alias
alias v="vim"

#TMUX Alias
alias ta="tmux attach"

#Git Alias
alias git="hub"

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
alias ls="ls -G"
