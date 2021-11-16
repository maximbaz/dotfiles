version = "0.16.3"

package.path = os.getenv("XDG_CONFIG_HOME") .. "/xplr/?/init.lua"

require("ui").setup()
require("keys").setup()
require("visit-path").setup()

package.path = os.getenv("XDG_CONFIG_HOME") .. "/xplr/?/src/init.lua"
require("trash-cli").setup()
