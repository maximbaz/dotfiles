spaceship_rename_terminal_window() {
  kitty @ set-window-title "${PWD/#$HOME/~}"
}

export SPACESHIP_PROMPT_ORDER=(
  rename_terminal_window
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
