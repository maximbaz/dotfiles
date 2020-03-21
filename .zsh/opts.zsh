# Enable decent options. See http://zsh.sourceforge.net/Doc/Release/Options.html.
emulate zsh                      # restore default options just in case something messed them up

setopt ALWAYS_TO_END             # Move cursor to the end of a completed word.
setopt AUTO_CD                   # Auto changes to a directory without typing cd.
setopt AUTO_LIST                 # Automatically list choices on ambiguous completion.
setopt AUTO_MENU                 # Show completion menu on a successive tab press.
setopt AUTO_PARAM_SLASH          # If completed parameter is a directory, add a trailing slash.
setopt AUTO_PUSHD                # `cd` pushes directories to the directory stack
setopt AUTO_RESUME               # Attempt to resume existing job before creating a new process.
setopt C_BASES                   # print hex/oct numbers as 0xFF/077 instead of 16#FF/8#77
setopt CDABLE_VARS               # Change directory to a path stored in a variable.
setopt COMBINING_CHARS           # Combine zero-length punctuation characters (accents) # with the base character.
setopt COMPLETE_IN_WORD          # complete from the cursor rather than from the end of the word
setopt EXTENDED_HISTORY          # write timestamps to history
setopt HIST_BEEP                 # Beep when accessing non-existent history.
setopt HIST_EXPIRE_DUPS_FIRST    # if history needs to be trimmed, evict dups first
setopt HIST_FIND_NO_DUPS         # don't show dups when searching history
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # don't add consecutive dups to history
setopt HIST_IGNORE_SPACE         # don't add commands starting with space to history
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # if a command triggers history expansion, show it instead of running
setopt IGNORE_EOF                # To bind my Ctrl+D widget
setopt INTERACTIVE_COMMENTS      # allow comments in command line
setopt LONG_LIST_JOBS            # List jobs in the long format by default.
setopt MULTIOS                   # allow multiple redirections for the same fd
setopt NO_BG_NICE                # don't nice background jobs
setopt NO_CHECK_JOBS             # Don't report on jobs when shell exit.
setopt NO_FLOW_CONTROL           # disable start/stop characters in shell editor
setopt NO_HUP                    # Don't kill jobs on shell exit.
setopt NO_MAIL_WARNING           # Don't print a warning message if a mail file has been accessed.
setopt NO_MENU_COMPLETE          # Do not autoselect the first completion entry.
setopt NOTIFY                    # Report status of background jobs immediately.
setopt PATH_DIRS                 # perform path search even on command names with slashes
setopt PUSHD_IGNORE_DUPS         # Do not store duplicates in the stack.
setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME             # Push to home directory when no argument is given.
setopt RC_QUOTES                 # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
setopt SHARE_HISTORY             # write and import history on every command
