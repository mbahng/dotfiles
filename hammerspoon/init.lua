hs.hotkey.bind({"alt", "ctrl"}, "R", function() hs.reload() end)
hs.alert.show("Config loaded")
hs.window.animationDuration = 0

local hyper = { "alt" }
local new_window_hyper = { "cmd" }

-- Global Application Launcher
function create_shortcut(hyper, key, name)
	hs.hotkey.bind(hyper, key, function()
		local app = hs.application.get(name)
		if app == nil or app:mainWindow() == nil then
			hs.application.open(name, 0.2)
		else
			hs.application.open(name, 0.2)
			hs.eventtap.keyStroke(new_window_hyper, "N")
		end
	end)
end

create_shortcut({"ctrl", "cmd"}, "T", "kitty")
create_shortcut({"alt"}, "B", "firefox")
create_shortcut({"alt"}, "S", "slack")
create_shortcut({"alt"}, "M", "spotify")
create_shortcut({"alt"}, "F", "messenger")
create_shortcut({"alt"}, "K", "kakaotalk")
create_shortcut({"alt"}, "W", "wechat")
create_shortcut({"alt"}, "I", "messages")
create_shortcut({"alt"}, "D", "discord")
create_shortcut({"alt"}, "U", "zulip")
create_shortcut({"alt"}, "Z", "zoom.us")
create_shortcut({"alt"}, "V", "visual studio code")
create_shortcut({"alt"}, "E", "Finder")


-- create_shortcut("E", "Finder")
--
-- hs.hotkey.bind(hyper, "V", function()
-- 	local name = "/Applications/Visual Studio Code.app"
-- 	local app = hs.application.get(name)
-- 	if app == nil or app:mainWindow() == nil then
-- 		hs.application.open(name, 0.2)
-- 	else
-- 		hs.application.open(name, 0.2)
-- 		hs.eventtap.keyStroke({ "cmd", "shift" }, "N")
-- 	end
-- end)
--
-- hs.hotkey.bind(hyper, "N", function()
-- 	hs.execute("open -n /Applications/LibreWolf.app")
-- end)
--
-- hs.hotkey.bind(hyper, "M", function()
-- 	hs.execute("open -n /Applications/Firefox.app")
-- end)
--
--
-- -- Sleep
-- hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "L", function()
-- 	hs.caffeinate.systemSleep()
-- end)
