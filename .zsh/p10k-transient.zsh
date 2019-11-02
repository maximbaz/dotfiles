# Run this function from ~/.zshrc to enable transient kubernetes and/or azure
# prompt segments in Powerlevel10k.
#
# By default, Powerlevel10k displays the current kubernetes context whenever there
# is one. Likewise for the current azure subscription name.  This function changes
# this behavior so that these segments are shown only when the current (not yet
# executed) command in $BUFFER matches a specified pattern
#
# The function is controlled by two parameters:
#
#   TRANSIENT_PROMPT_KUBECONTEXT_CMD: command pattern that triggers the display of
#   kubecontext.
#
#   TRANSIENT_PROMPT_AZURE_CMD: command pattern that triggers the display of azure.
#
# Example configuration:
#
#   # Show kubecontext only when the current command is `kubectl` or `path/kubectl`.
#   TRANSIENT_PROMPT_KUBECONTEXT_CMD='(*/|)kubectl'
#
#   # Show azure only when the current command is `az`, `path/az`, `terraform`, or
#   # `path/terraform`.
#   TRANSIENT_PROMPT_AZURE_CMD='(*/|)(az|terraform)'
() {
  emulate -L zsh
  zmodload zsh/parameter

  function _transient-prompt-segment-wrap-widget() {
    local widget=$1
    local post=$2
    local prefix=transient-prompt-segment
    local orig=${prefix}-orig-${widget}

    case $widgets[$widget] in
      user:$prefix-*)
        ;;
      user:*)
        zle -N $orig ${widgets[$widget]#user:}
        ;;
      builtin)
        eval "function ${(q)orig}() { zle .${(q)widget} }"
        zle -N $orig
        ;;
    esac

    local wrapper=${prefix}-wrapper-${widget}
    eval "function ${(q)wrapper}() {
      local -i ret
      (( ! \${+widgets[${(q)orig}]} )) || zle ${(q)orig} -- \"\$@\" || ret=\$?
      ${(q)post} \"\$@\"
      return \$ret
    }"

    zle -N -- ${widget} $wrapper
  }

  function _transient-prompt-segment-on-buf-change() {
    emulate -L zsh
    unsetopt banghist
    local cmd="${(Q)${(Az)BUFFER}[1]}"
    if (( $+aliases[$cmd] )); then
      if functions[_transient-prompt-segment-cmd]=${(q)cmd} 2>/dev/null; then
        cmd="${(Q)${(Az)functions[_transient-prompt-segment-cmd]}[1]}"
        unset 'functions[_transient-prompt-segment-cmd]'
      else
        cmd=
      fi
    fi

    local -i reset_prompt

    if [[ -n $cmd && $cmd == ${~TRANSIENT_PROMPT_KUBECONTEXT_CMD} ]]; then
      if (( ! $+parameters[_transient_kubecontext_on] )); then
        reset_prompt=1
        typeset -g _transient_kubecontext_on=
      fi
    else
      if (( $+parameters[_transient_kubecontext_on] )); then
        reset_prompt=1
        unset _transient_kubecontext_on
      fi
    fi

    if [[ -n $cmd && $cmd == ${~TRANSIENT_PROMPT_AZURE_CMD} ]]; then
      if (( ! $+parameters[_transient_azure_on] )); then
        reset_prompt=1
        typeset -g _transient_azure_on=
      fi
    else
      if (( $+parameters[_transient_azure_on] )); then
        reset_prompt=1
        unset _transient_azure_on
      fi
    fi

    if (( reset_prompt )); then
      zle .reset-prompt
      zle -R
    fi
  }

  function _transient-prompt-segment-hide() {
    unset _transient_kubecontext_on _transient_azure_on
  }

  function _transient-prompt-segment-init() {
    emulate -L zsh

    if [[ -n $TRANSIENT_PROMPT_KUBECONTEXT_CMD || -n TRANSIENT_PROMPT_AZURE_CMD ]]; then
      local widget
      for widget in ${${(k)widgets}:#.*}; do
        _transient-prompt-segment-wrap-widget $widget _transient-prompt-segment-on-buf-change
      done

      if [[ -n $TRANSIENT_PROMPT_KUBECONTEXT_CMD ]]; then
        local _ class param
        for _ class in ${^POWERLEVEL9K_KUBECONTEXT_CLASSES}_ ''; do
          for param in CONTENT VISUAL_IDENTIFIER; do
            local name=POWERLEVEL9K_KUBECONTEXT_${class}${param}_EXPANSION
            (( $+parameters[$name] )) && local val=${(P)name} || local val="\${P9K_$param}"
            typeset -g $name='${_transient_kubecontext_on+'$val'}'
          done
        done
      fi

      if [[ -n $TRANSIENT_PROMPT_AZURE_CMD ]]; then
        for param in CONTENT VISUAL_IDENTIFIER; do
          local name=POWERLEVEL9K_AZURE_${param}_EXPANSION
          (( $+parameters[$name] )) && local val=${(P)name} || local val="\${P9K_$param}"
          typeset -g $name='${_transient_azure_on+'$val'}'
        done
      fi
    fi

    add-zsh-hook -d precmd _transient-prompt-segment-init
    unfunction _transient-prompt-segment-init
    unfunction _transient-prompt-segment-wrap-widget
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _transient-prompt-segment-hide
  add-zsh-hook -d precmd _transient-prompt-segment-init
  precmd_functions=(_transient-prompt-segment-init $precmd_functions)
}
