alias sudo="sudo -E"
alias please='sudo $(fc -ln -1)'
alias vi="nvim"
alias vim="nvim"
alias psg="ps aux | grep "

# Git
alias gpu="git push -u"
alias gcob="git checkout -b"
alias gpf="git push -f"
alias ga.="git add ."
alias gf="git fetch"
alias gac="git add . && git commit --verbose"
alias gacmsg="ga. && gcmsg"
alias gdh="gd HEAD"
alias gdw="gd --color-words"
alias gdwh="gd --color-words HEAD"
alias glog="git log --graph --pretty=format:'%C(yellow)%h%Creset -%C(bold red)%d%Creset %s %C(dim green)(%cr) %C(cyan)<%cn>%Creset' --abbrev-commit"
alias gr="git reset"
alias gs="git show"
alias gf!="git commit --fixup"

# Debian
alias au="sudo apt-get update && sudo apt-get upgrade"

# Directory aliases
hash -d db="~/Dropbox"

# FZF aliases
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  . /usr/share/fzf/key-bindings.zsh
fi

if [ -f /usr/share/fzf/completion.zsh ]; then
  . /usr/share/fzf/completion.zsh
fi
