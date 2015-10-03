ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} ✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} ✔%{$reset_color%}"

PROMPT='
${ret_status}%{$fg_bold[yellow]%}[%*] %{$fg[green]%}$(print_ssh_user)%{$fg[cyan]%}$(print_cur_dir) %{$fg_bold[green]%}$(git_prompt_info) $(cabal_sandbox_info) %{$fg_bold[blue]%} % %{$reset_color%}
λ:  '


function print_cur_dir() {
  case $PWD in
    $HOME) echo "~";;
    *) echo "%C";;
  esac
}

function print_ssh_user() {
  local user=`whoami`
  if [[ -n "$SSH_CONNECTION" ]]; then
    echo "$user@%m "
  fi
}

function cabal_sandbox_info() {
  cabal_files=(*.cabal(N))
  if [ $#cabal_files -gt 0 ]; then
    if [ -f cabal.sandbox.config ]; then
      echo "%{$fg[yellow]%}[sandboxed]%{$reset_color%}"
    else
      echo "%{$fg[red]%}[not sandboxed]%{$reset_color%}"
    fi
  fi
}
