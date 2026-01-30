local awful = require("awful")

local config = {}

config.terminal = "xterm"
config.editor = "nvim"
config.editor_cmd = config.terminal .. " -e " .. config.editor

config.modkey = "Mod4"

return config
