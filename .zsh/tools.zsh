[ -f /etc/bash_completion.d/azure-cli ] && . /etc/bash_completion.d/azure-cli

export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"
