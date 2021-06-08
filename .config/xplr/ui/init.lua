local function setup()
    xplr.config.general.focus_ui.style.fg = "Cyan"
    xplr.config.node_types.directory.meta.icon = nil
    xplr.config.node_types.directory.style.fg = "Blue"
    xplr.config.node_types.file.meta.icon = nil
    xplr.config.node_types.file.style.add_modifiers = { "Dim" }
    xplr.config.node_types.symlink.meta.icon = nil
    xplr.config.node_types.symlink.style.sub_modifiers = { "Italic" }
end

return { setup = setup }
