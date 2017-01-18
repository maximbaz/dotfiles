alias g='git'

alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'

alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git add --all && git commit -v'
alias gca!='git add --all && git commit -v --amend'
alias gcan!='git add --all && git commit -v --amend --no-edit'
alias gcamsg='git add --all && git commit -m'
alias gcmsg='git commit -m'
alias gcf='git commit --fixup'

alias gcl='git clone --recursive'

alias gcm='git checkout master'
alias gco='git checkout'
alias gcob='git checkout -b'

alias gd='git diff'
alias gds='git diff --cached'

alias gf='git fetch'
alias gl='git pull'

alias glog="git log --graph --pretty='%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(blue)<%an>%Creset' --abbrev-commit"
alias gloga="git log --graph --pretty='%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias glogp='git log -p'

alias gm='git merge'

alias gp='git push'
alias gpu='git push -u'

alias gr='git remote'
alias gra='git remote add'
alias grr='git remote remove'
alias grv='git remote -v'

alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase -i master'
alias grbom='git rebase -i origin/master'

alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'

alias gs='git show'

alias gss='git status -sb'
alias gst='git status'

