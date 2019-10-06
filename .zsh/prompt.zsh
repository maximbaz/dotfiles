typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=white,bold'


'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh
  setopt no_unset extended_glob
  zmodload zsh/langinfo
  if [[ ${langinfo[CODESET]:-} != (utf|UTF)(-|)8 ]]; then
    local LC_ALL=${${(@M)$(locale -a):#*.(utf|UTF)(-|)8}[1]:-en_US.UTF-8}
  fi

  unset -m 'POWERLEVEL9K_*'

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      time
      context
      dir
      vcs
      kubecontext
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

  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'
  typeset -g POWERLEVEL9K_MODE=awesome-fontconfig
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' '

  ################################[ background_jobs: background jobs indicator ]################
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=red
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION=" "

  ################################[ context: shows root user ]#################################
  typeset -g DEFAULT_USER=maximbaz
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=red
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
  typeset -g POWERLEVEL9K_CONTEXT_PREFIX="%fas "

  ################################[ prompt_char: prompt symbol ]################################
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=green
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=red
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'

  ##################################[ dir: current directory ]##################################
  typeset -g POWERLEVEL9K_DIR_PREFIX='%fin '
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=065
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=065
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
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50

  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=true
  typeset -g POWERLEVEL9K_DIR_CLASSES=()

  #####################################[ vcs: git status ]######################################
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '

  local vcs=''
  vcs+='${${VCS_STATUS_LOCAL_BRANCH:+%5F'${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}
  vcs+='${${${$(( ${#VCS_STATUS_LOCAL_BRANCH}<=32 )):#0}:+${VCS_STATUS_LOCAL_BRANCH//\%/%%}}'
  vcs+=':-${${VCS_STATUS_LOCAL_BRANCH:0:12}//\%/%%}%28F…%76F${${VCS_STATUS_LOCAL_BRANCH: -12}//\%/%%}}}'
  vcs+=':-%f@%76F${VCS_STATUS_COMMIT:0:8}}'
  vcs+='${${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH}:+%f:%76F${VCS_STATUS_REMOTE_BRANCH//\%/%%}}'
  vcs+='${VCS_STATUS_TAG:+%f#%76F${VCS_STATUS_TAG//\%/%%}}'
  vcs+='${${$(( VCS_STATUS_STASHES + VCS_STATUS_NUM_CONFLICTED + VCS_STATUS_NUM_UNSTAGED + VCS_STATUS_NUM_UNTRACKED + VCS_STATUS_NUM_STAGED + VCS_STATUS_COMMITS_BEHIND + VCS_STATUS_COMMITS_AHEAD )):#0}:+ }'
  vcs+='${${VCS_STATUS_STASHES:#0}:+%6F●}'
  vcs+='${${VCS_STATUS_NUM_CONFLICTED:#0}:+%5F●}'
  vcs+='${VCS_STATUS_ACTION:+%196Fx}'
  # TODO deleted?
  vcs+='${${VCS_STATUS_NUM_UNSTAGED:#0}:+%3F●}'
  vcs+='${${VCS_STATUS_NUM_UNTRACKED:#0}:+%4F●}'
  vcs+='${${VCS_STATUS_NUM_STAGED:#0}:+%2F●}'
  vcs+='${${VCS_STATUS_COMMITS_BEHIND:#0}:+%3F}'
  vcs+='${${VCS_STATUS_COMMITS_AHEAD:#0}:+%3F}'

  vcs="\${P9K_CONTENT:-$vcs}"

  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION=$vcs
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION=${${${vcs//\%f}//\%<->F}//\%F\{(\#|)[[:xdigit:]]#(\\|)\}}
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1

  typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_EXPANSION=
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

  #############[ kubecontext: current kubernetes context (https://kubernetes.io/) ]#############
  typeset -g POWERLEVEL9K_KUBECONTEXT_PREFIX='%fat '

  typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
      '*-prod-*'  PROD
      '*'         DEFAULT)
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=blue
  typeset -g POWERLEVEL9K_KUBECONTEXT_PROD_FOREGROUND=red

  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION=
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'

  ####################################[ time: current time ]####################################
  typeset -g POWERLEVEL9K_TIME_PREFIX='%f'

  typeset -g POWERLEVEL9K_TIME_FOREGROUND=yellow
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=true
  typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION=
}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
