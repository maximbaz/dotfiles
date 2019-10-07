typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=white,bold'

() {
  emulate -L zsh
  setopt no_unset extended_glob

  unset -m 'POWERLEVEL9K_*'

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      time
      user
      dir
      vcs
      kubecontext
      azure
      command_execution_time
      background_jobs

      newline
      prompt_char
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  typeset -g POWERLEVEL9K_BACKGROUND=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=

  typeset -g POWERLEVEL9K_MODE=awesome-fontconfig
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  ################################[ background_jobs: background jobs indicator ]################
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=red
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION=" "

  ################################[ user: shows root user ]#################################
  typeset -g POWERLEVEL9K_USER_FOREGROUND=red
  typeset -g POWERLEVEL9K_USER_PREFIX="%fas "
  typeset -g POWERLEVEL9K_USER_CONTENT_EXPANSION=
  typeset -g POWERLEVEL9K_USER_ROOT_CONTENT_EXPANSION='%B${P9K_CONTENT}'

  ################################[ prompt_char: prompt symbol ]################################
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=green
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=red
  typeset -g POWERLEVEL9K_PROMPT_CHAR_CONTENT_EXPANSION='❯'

  ##################################[ dir: current directory ]##################################
  typeset -g POWERLEVEL9K_DIR_PREFIX='%fin '
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=065
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=cyan
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true

  local anchor_files=(
    .git
    .node-version
    .python-version
    .ruby-version
    .shorten_folder_marker
    .svn
    .terraform
    Cargo.toml
    go.mod
    package.json
  )

  typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80

  #####################################[ vcs: git status ]######################################
  function gitstatus_formatter() {
    if [[ -n "$P9K_CONTENT" ]]; then
      typeset -g gitstatus_format="$P9K_CONTENT"
      return
    fi

    if (( $1 )); then
      # Styling for up-to-date Git status.
      local meta='%F{yellow}'
      local clean='%F{magenta}'
      local stashes='%F{cyan}'
      local conflicted='%F{magenta}'
      local removed='%F{red}'
      local unstaged='%F{yellow}'
      local untracked='%F{blue}'
      local staged='%F{green}'
      local outofsync='%F{yellow}'
    else
      # Styling for incomplete and stale Git status.
      local meta='%F{white}'
      local clean='%F{white}'
      local stashes='%F{white}'
      local conflicted='%F{white}'
      local removed='%F{white}'
      local unstaged='%F{white}'
      local untracked='%F{white}'
      local staged='%F{white}'
      local outofsync='%F{white}'
    fi

    local res
    local where  # branch name, tag or commit
    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      res+="${clean} "
      where=${(V)VCS_STATUS_LOCAL_BRANCH}
    elif [[ -n $VCS_STATUS_TAG ]]; then
      res+="${meta}#"
      where=${(V)VCS_STATUS_TAG}
    else
      res+="${meta}@"
      where=${VCS_STATUS_COMMIT[1,8]}
    fi

    # If local branch name or tag is at most 32 characters long, show it in full.
    # Otherwise show the first 12 … the last 12.
    (( $#where > 32 )) && where[13,-13]="…"
    res+="${clean}${where//\%/%%}"  # escape %

    # Show tracking branch name if it differs from local branch.
    if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
      res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"  # escape %
    fi

    # Detect 'removed' unstaged files until gitstatus supports this natively
    local porcelain="$(command git status --porcelain -b 2>/dev/null)"
    local vcs_status_has_removed=$( ! echo "$porcelain" | command grep '^[ MARC ]D ' &>/dev/null; echo $?)
    local vcs_status_has_unstaged=$(! echo "$porcelain" | command grep '^[ MARC ]M ' &>/dev/null; echo $?)

    # Add a space before showing git status icons, if there are any
    (( VCS_STATUS_STASHES        ||
       VCS_STATUS_NUM_CONFLICTED ||
       vcs_status_has_removed    ||
       vcs_status_has_unstaged   ||
       VCS_STATUS_NUM_UNTRACKED  ||
       VCS_STATUS_NUM_STAGED     ||
       VCS_STATUS_COMMITS_BEHIND ||
       VCS_STATUS_COMMITS_AHEAD  )) && res+=' '

    # Show various git status icons
    (( VCS_STATUS_STASHES ))        && res+="${stashes}●"
    (( VCS_STATUS_NUM_CONFLICTED )) && res+="${conflicted}●"
    (( vcs_status_has_removed ))    && res+="${removed}●"
    (( vcs_status_has_unstaged ))   && res+="${unstaged}●"
    (( VCS_STATUS_NUM_UNTRACKED ))  && res+="${untracked}●"
    (( VCS_STATUS_NUM_STAGED ))     && res+="${staged}●"

    if (( VCS_STATUS_COMMITS_BEHIND && VCS_STATUS_COMMITS_AHEAD )); then
      res+="${outofsync}"
    elif (( VCS_STATUS_COMMITS_BEHIND )); then
      res+="${outofsync}"
    elif (( VCS_STATUS_COMMITS_AHEAD )); then
      res+="${outofsync}"
    fi

    typeset -g gitstatus_format="$res"
  }
  functions +M -m gitstatus_formatter && functions -M gitstatus_formatter

  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='%B${$((gitstatus_formatter(1)))+${gitstatus_format}}'
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='%B${$((gitstatus_formatter(0)))+${gitstatus_format}}'
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

  typeset -g POWERLEVEL9K_VCS_PREFIX='%fon '

  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=244

  ###################[ command_execution_time: duration of the last command ]###################
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='%ftook '

  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=yellow
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_CONTENT_EXPANSION='%B${P9K_CONTENT}'

  #############[ kubecontext: current kubernetes context (https://kubernetes.io/) ]#############
  typeset -g POWERLEVEL9K_KUBECONTEXT_PREFIX='%fat '
  typeset -g POWERLEVEL9K_KUBECONTEXT_VISUAL_IDENTIFIER_EXPANSION='☸️'

  typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
      '*-prod-*'  PROD
      '*'         DEFAULT)
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=blue
  typeset -g POWERLEVEL9K_KUBECONTEXT_PROD_FOREGROUND=red

  typeset -g POWERLEVEL9K_KUBECONTEXT_CONTENT_EXPANSION='%B'
  POWERLEVEL9K_KUBECONTEXT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
  POWERLEVEL9K_KUBECONTEXT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'

  ####################################[ azure: azure subscription ]#############################
  function prompt_azure() {
    local val="$(jq -r '.subscriptions[] | select(.isDefault == true) | .name' $HOME/.azure/azureProfile.json)"
    p10k segment -f 208 -t "$val"
  }

  typeset -g POWERLEVEL9K_AZURE_PREFIX='%fusing '
  typeset -g POWERLEVEL9K_AZURE_VISUAL_IDENTIFIER_EXPANSION="☁️"
  typeset -g POWERLEVEL9K_AZURE_CONTENT_EXPANSION='%B${P9K_CONTENT}'

  ####################################[ time: current time ]####################################
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=yellow
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=true
  typeset -g POWERLEVEL9K_TIME_CONTENT_EXPANSION='%B${P9K_CONTENT}'
}
