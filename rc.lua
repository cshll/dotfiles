local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

if awesome.startup_errors then
	naughty.notify({ 
		preset = naughty.config.presets.critical,
                title = "Oops, there were errors during startup!",
                text = awesome.startup_errors 
	})
end

do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
        	if in_error then return end
        	in_error = true
        	naughty.notify({ 
			preset = naughty.config.presets.critical,
                        title = "Oops, an error happened!",
                        text = tostring(err) 
		})
        	in_error = false
    	end)
end

local config = require("config")
local keys = require("keys")
local rules = require("rules")

beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/default/theme.lua")

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
}

awful.screen.connect_for_each_screen(function(s)
	if beautiful.wallpaper then
        	local wallpaper = beautiful.wallpaper
        	if type(wallpaper) == "function" then
            		wallpaper = wallpaper(s)
        	end
        	gears.wallpaper.maximized(wallpaper, s, true)
    	end

    	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
end)

root.buttons(gears.table.join(
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
))

root.keys(keys.globalkeys)

awful.rules.rules = rules.create(keys.clientkeys, clientbuttons)

client.connect_signal("manage", function (c)
	if awesome.startup and 
	not c.size_hints.user_position and 
	not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
    	end
end)

client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
