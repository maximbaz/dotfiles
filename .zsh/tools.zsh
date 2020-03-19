export PATH="$PATH:/opt/azure-cli/bin"
. az.completion.sh >/dev/null

export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"
