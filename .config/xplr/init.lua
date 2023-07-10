version = "0.21.0"

package.path = os.getenv("XDG_CONFIG_HOME") .. "/xplr/?/init.lua"

require("ui").setup()
require("keys").setup()
require("visit-path").setup()
require("trash-cli").setup()
require("wl-clipboard").setup{
  copy_command = "wl-copy -t text/uri-list"
}
