spaceship_reset_tmux_pane_title() {
  # Reset tmux pane title
  printf '\033]2;%s\033\\' ''
}

export SPACESHIP_PROMPT_ORDER=(
  reset_tmux_pane_title
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

export SPACESHIP_CHAR_SYMBOL="❯ "
export SPACESHIP_JOBS_SYMBOL="»"
export SPACESHIP_TIME_SHOW=true
export SPACESHIP_USER_PREFIX="as "
export SPACESHIP_USER_SHOW="needed"
export SPACESHIP_DIR_LOCK_SYMBOL=" "
export SPACESHIP_DIR_TRUNC_PREFIX=".../"
export SPACESHIP_DIR_TRUNC_REPO=false
