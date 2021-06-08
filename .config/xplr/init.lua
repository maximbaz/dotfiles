version = "0.14.0"

-- ui
xplr.config.general.focus_ui.style.fg = "Cyan"
xplr.config.node_types.directory.meta.icon = nil
xplr.config.node_types.directory.style.fg = "Blue"
xplr.config.node_types.file.meta.icon = nil
xplr.config.node_types.file.style.add_modifiers = { "Dim" }
xplr.config.node_types.symlink.meta.icon = nil
xplr.config.node_types.symlink.style.sub_modifiers = { "Italic" }

-- keys: default mode
key = xplr.config.modes.builtin.default.key_bindings.on_key

key.a = key["ctrl-a"]
key["ctrl-f"] = nil
key.e = xplr.config.modes.builtin.action.key_bindings.on_key.e
key.o = xplr.config.modes.builtin.go_to.key_bindings.on_key.x

key["ctrl-a"] = nil
key["ctrl-w"] = nil
key["ctrl-r"] = nil
key["ctrl-i"] = nil
key["ctrl-o"] = nil
key.v = nil
key.V = nil

key["!"] = {
    help = "shell",
    messages = {
        { Call = { command = "zsh", args = { "-i" } } },
        ExplorePwdAsync,
        PopMode,
    },
}

key.D = {
    help = "disk usage",
    messages = {
        { Call = { command = "ncdu" } },
        ClearScreen,
    },
}

key.n = {
    help = "go to nzb",
    messages = {
        { ChangeDirectory = "/home/nzbget/dst" },
    },
}

-- keys: action mode
key = xplr.config.modes.builtin.action.key_bindings.on_key

key.e = nil
key.l = {
    help = "logs",
    messages = {
        { BashExec = [[ cat -- "${XPLR_PIPE_LOGS_OUT}" | less -+F ]] },
        PopMode,
    },
}

-- keys: delete mode
key = xplr.config.modes.builtin.delete.key_bindings.on_key

key.d = {
    help = "delete",
    messages = {
        {
            BashExecSilently = [===[
                while IFS= read -r line; do rmtrash -rf -- "${line:?}"; done < "${XPLR_PIPE_RESULT_OUT:?}"
                echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
            ]===],
        },
        PopMode,
    },
}

key.D = {
    help = "force delete",
    messages = {
        {
            BashExecSilently = [===[
                while IFS= read -r line; do rm -rf -- "${line:?}"; done < "${XPLR_PIPE_RESULT_OUT:?}"
                echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
            ]===],
        },
        PopMode,
    },
}

-- keys: go to
key = xplr.config.modes.builtin.go_to.key_bindings.on_key

key.k = key.g
key.j = xplr.config.modes.builtin.default.key_bindings.on_key.G
key.x = nil

-- keys: search mode
key = xplr.config.modes.builtin.search.key_bindings.on_key

key["ctrl-p"] = key["tab"]
key["tab"] = key.right
key["ctrl-j"] = key.down
key["ctrl-k"] = key.up
key["ctrl-n"] = nil
