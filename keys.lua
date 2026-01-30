local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

local config = require("config")
local modkey = config.modkey

local keys = {}

keys.globalkeys = gears.table.join(
	awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
        	{description="show help", group="awesome"}),
	awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
        	{description = "view previous", group = "tag"}),
	awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
        	{description = "view next", group = "tag"}),
	awful.key({ modkey,           }, "Return", function () awful.spawn(config.terminal) end,
        	{description = "open a terminal", group = "launcher"}),
	awful.key({ modkey, "Control" }, "r",      awesome.restart,
        	{description = "reload awesome", group = "awesome"}),
	awful.key({ modkey, "Shift"   }, "q",      awesome.quit,
        	{description = "quit awesome", group = "awesome"})
)

keys.clientkeys = gears.table.join(
	awful.key({ modkey,           }, "f", function (c)
        	c.fullscreen = not c.fullscreen
        	c:raise()
	end,
	{description = "toggle fullscreen", group = "client"}),
	awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
        	{description = "close", group = "client"}),
	awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
        	{description = "toggle floating", group = "client"})
)

return keys
