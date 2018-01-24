# Configure prezto
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' dot-expansion 'yes'

# Patches prezto with my own adjustments
prezto_apply_patches() (
  if [ "$(whoami)" != "root" ]; then
    cd "$HOME/.antigen/bundles/sorin-ionescu/prezto"
    patch -p1 -f -r - --no-backup-if-mismatch < "$HOME/.dotfiles/.zprezto-patches/prompt.patch" >/dev/null 2>&1
    patch -p1 -f -r - --no-backup-if-mismatch < "$HOME/.dotfiles/.zprezto-patches/wordchars.patch" >/dev/null 2>&1
  fi
)

# Revert applied patches (needed for updates)
prezto_revert_patches() (
  if [ "$(whoami)" != "root" ]; then
    cd "$HOME/.antigen/bundles/sorin-ionescu/prezto"
    git reset --hard HEAD >/dev/null 2>&1
  fi
)

# Configure zsh-notify
zstyle ':notify:*' command-complete-timeout 15
zstyle ':notify:*' error-title 'Error'
zstyle ':notify:*' success-title 'Success'
zstyle ':notify:*' error-icon '/usr/share/icons/Adwaita/256x256/status/dialog-error.png'
zstyle ':notify:*' success-icon '/usr/share/icons/Adwaita/256x256/status/dialog-information.png'

# Load antigen
source /usr/share/zsh/share/antigen.zsh

antigen use prezto

antigen bundles <<EOB
  environment
  editor
  history
  directory
  completion
  archive
  robbyrussell/oh-my-zsh plugins/encode64
  robbyrussell/oh-my-zsh plugins/fancy-ctrl-z
  hlissner/zsh-autopair
  marzocchi/zsh-notify
  rupa/z
  changyuheng/fz
  Tarrasch/zsh-bd
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
EOB

antigen theme maximbaz/spaceship-zsh-theme@3.0

antigen apply

# Fix prezto functions loading
autoload -Uz archive lsarchive unarchive

# Configure prompt
export SPACESHIP_CHAR_SYMBOL="❯ "
export SPACESHIP_JOBS_SYMBOL="»"
export SPACESHIP_TIME_SHOW=true
export SPACESHIP_USER_PREFIX="as "
export SPACESHIP_DIR_TRUNC_REPO=false
export SPACESHIP_USER_SHOW="needed"

export SPACESHIP_PROMPT_ORDER=(
  time
  user
  dir
  host
  git
  exec_time
  line_sep
  jobs
  exit_code
  char
)

# Configure git prompt symbols
export SPACESHIP_GIT_STATUS_DELETED="x"
export SPACESHIP_GIT_STATUS_AHEAD=""
export SPACESHIP_GIT_STATUS_BEHIND=""
export SPACESHIP_GIT_STATUS_DIVERGED=""

# Ensure my prezto patches are applied (it's fine to do asynchronously)
prezto_apply_patches &!

# Define some extra key bindings
bindkey -M emacs "$key_info[Up]" history-substring-search-up
bindkey -M emacs "$key_info[Down]" history-substring-search-down
bindkey -M emacs "$key_info[Control]K" backward-kill-line
bindkey -M emacs "$key_info[Control]V$key_info[Control]V" edit-command-line
