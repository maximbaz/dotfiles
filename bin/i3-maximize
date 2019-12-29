#!/bin/bash

########################################################
#
#           ##  i3_maximize.sh  ##
#
# Implements maximization of a window in i3.
# Swaps the focused container into a new workspace and
# and restores it when run again.
#
# Supports multiple displays.
#
# Fetch this script. Then edit ~/.i3/config:
#
#     # toggle maximized mode for the focused container
#     bindsym $mod+f exec ~/scripts/i3_maximize.sh
#
#     # enter fullscreen mode for the focused container
#     bindsym $mod+Shift+f fullscreen
#
#
########################################################

if ! type "jq" 2>1 > /dev/null; then
  echo "Missing jq dependency. Install with:"
  echo "  sudo apt install jq"
  exit 1
fi

# Apply a suffix to everything so this works independently for multiple outputs.
DISPLAY_ID=$( i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).output' | sed s/[^A-Za-z0-9]//g )

# The name of the workspace we'll create.
MAX_WS="MAXIMIZED_${DISPLAY_ID}"

# The name of the container which will be swapped to the new workspace.
MAX="MAXIMIZED_CONTAINER_${DISPLAY_ID}"

# The name of the container we'll put in its place while maximized
HOLE="HOLE_${DISPLAY_ID}"

# Helper: swaps the focused container into the new "maximized" workspace.
maximize() {
  i3-msg "mark ${MAX}; workspace ${MAX_WS}; open; mark ${HOLE}; swap container with mark ${MAX}"
}

# Helper: puts the maximized container back in its prior position
# arg $1: whether or not to focus restored container
restore() {
  CMD="[con_mark=${HOLE}] swap container with mark ${MAX}; [con_mark=${HOLE}] kill;"
  if [ $1 = true ]; then
    # Set focus to restored window.
    CMD="${CMD} [con_mark=${MAX}] focus;"
  fi
  CMD="${CMD} unmark ${MAX}; unmark ${HOLE}"
  i3-msg "${CMD}"
}

# Workspace we're currently showing.
CURRENT_WS=$( i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name' )

if [ "${CURRENT_WS}" = "${MAX_WS}" ]; then
  # CASE: currently displaying the maximize workspace.

  # Restore the container and focus.
  restore true
  exit 0
fi

MAX_WS_GET=$( i3-msg -t get_workspaces | jq -r ".[] | select(.name==\"${MAX_WS}\")" )

if [ -z "${MAX_WS_GET}" ]; then
  # CASE: no existing maximize workspace

  # Attempt to clean up an existing hole. This can happen if the maximized
  # window is closed without unmaximizing first.
  i3-msg "[con_mark=${HOLE}] kill"

  # Maximize the focused container
  maximize
  exit 0
fi

# CASE: existing maximize workspace somewhere else.

# Put existing maximized container back in its place first.
restore false

# Then maximize focused container.
maximize

exit 0
