# Fix prompts
setopt prompt_subst

# Configure prezto
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' dot-expansion 'yes'

# Patches prezto with my own adjustments
patch_prezto() (
  if [ "$(whoami)" != "root" ]; then
    cd "$HOME/.antigen/bundles/sorin-ionescu/prezto"
    patch -p1 -f -r - --no-backup-if-mismatch < "$HOME/.dotfiles/.zprezto-patches/prompt.patch" >/dev/null 2>&1
    patch -p1 -f -r - --no-backup-if-mismatch < "$HOME/.dotfiles/.zprezto-patches/wordchars.patch" >/dev/null 2>&1
  fi
)

# Resets applied patches (needed for updates)
restore_prezto() (
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

# Configure prompt
export SPACESHIP_LSCOLORS_DEFINE=false
export SPACESHIP_PROMPT_SYMBOL="❯"
export SPACESHIP_JOBS_SYMBOL="»"
export SPACESHIP_TIME_SHOW=true
export SPACESHIP_USER_PREFIX="as "

export SPACESHIP_PROMPT_ORDER=(
  time
  user
  host
  dir
  git
  exec_time
  line_sep
  battery
  jobs
  exit_code
  char
)

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
  robbyrussell/oh-my-zsh lib/git.zsh
  hlissner/zsh-autopair
  marzocchi/zsh-notify
  rupa/z
  changyuheng/fz
  Tarrasch/zsh-bd
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
EOB

antigen theme denysdovhan/spaceship-zsh-theme

antigen apply

# Configure git prompt symbols
export SPACESHIP_GIT_STATUS_DELETED="x"
export SPACESHIP_GIT_STATUS_AHEAD=
export SPACESHIP_GIT_STATUS_BEHIND=
export SPACESHIP_GIT_STATUS_DIVERGED=

# Ensure my prezto patches are applied (it's fine to do asynchronously)
patch_prezto &!

# Define some extra key bindings
bindkey -M emacs "$key_info[Up]" history-substring-search-up
bindkey -M emacs "$key_info[Down]" history-substring-search-down
bindkey -M emacs "$key_info[Control]K" backward-kill-line
bindkey -M emacs "$key_info[Control]V$key_info[Control]V" edit-command-line
