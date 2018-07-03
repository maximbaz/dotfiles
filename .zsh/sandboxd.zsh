#!/usr/bin/zsh
# Credits: https://github.com/benvan/sandboxd

# holds all hook descriptions in "cmd:hook" format
sandbox_hooks=()

# deletes all hooks associated with cmd
function sandbox_delete_hooks() {
  local cmd=$1
  for i in "${sandbox_hooks[@]}";
  do
    if [[ $i == "${cmd}:"* ]]; then
      local hook=$(echo $i | sed "s/.*://")
      unset -f "$hook"
    fi
  done
}

# prepares environment and removes hooks
function sandbox() {
  local cmd=$1
  if [[ "$(type $cmd | grep -o function)" = "function" ]]; then
    (>&2 echo "Lazy-loading $cmd for the first time...")
    sandbox_delete_hooks $cmd
    sandbox_init_$cmd
  else
    (>&2 echo "sandbox '$cmd' not found.\nIs 'sandbox_init_$cmd() { ... }' defined and 'sandbox_hook $cmd $cmd' called?")
    return 1
  fi
}

function sandbox_hook() {
  local cmd=$1
  local hook=$2

  sandbox_hooks+=("${cmd}:${hook}")

  eval "$hook(){ sandbox $cmd; $hook \$@ }"
}
