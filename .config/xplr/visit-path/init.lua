local function setup()
    xplr.config.modes.custom.visit_path = {
        name = "visit path",
        key_bindings = {
            on_key = {
                enter = {
                    messages = {
                        {
                            BashExecSilently = [===[
                                dir="$(echo "${XPLR_INPUT_BUFFER:?}" | sed 's|~|/home/maximbaz|g')"
                                echo "FocusPath: $dir" >> "${XPLR_PIPE_MSG_IN:?}"
                            ]===],
                        },
                        "PopMode",
                    },
                },
                esc = {
                    help = "cancel",
                    messages = { "PopMode" },
                },
                ["ctrl-c"] = {
                    help = "terminate",
                    messages = { "Terminate" },
                },
                backspace = {
                    help = "remove last character",
                    messages = { "RemoveInputBufferLastCharacter" },
                },
                ["ctrl-u"] = {
                    help = "remove line",
                    messages = { { SetInputBuffer = "" } },
                },
                ["ctrl-w"] = {
                    help = "remove last word",
                    messages = { "RemoveInputBufferLastWord" },
                },
            },
            default = {
                messages = { "BufferInputFromKey" },
            },
        },
    }
end

return { setup = setup }
