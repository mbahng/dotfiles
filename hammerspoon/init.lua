hs.hotkey.bind({"alt"}, "R", function() hs.reload() end)
hs.alert.show("Config loaded")
hs.window.animationDuration = 0
local hyper = { "alt" }
local new_window_hyper = { "cmd" }
--
-- -- Global Application Launcher
-- function create_shortcut(hyper, key, name)
--     hs.hotkey.bind(hyper, key, function()
--         local app = hs.application.get(name)
--         if app == nil or app:mainWindow() == nil then
--             hs.application.open(name, 1.0)
--         else
--             hs.application.open(name, 1.0)
--             hs.eventtap.keyStroke(new_window_hyper, "N")
--         end
--     end)
-- end
-- -- create_shortcut({"alt"}, "B", "firefox")
--
-- function focusNextDisplay()
--     local focusedScreen = hs.screen.mainScreen()
--     local nextScreen = focusedScreen:next()
--     -- Get all windows on the next screen
--     local windows = hs.fnutils.filter(hs.window.orderedWindows(), function(w)
--         return w:screen() == nextScreen and w:isStandard()
--     end)
--     -- Focus the first window found on that screen
--     if #windows > 0 then
--         windows[1]:focus()
--     end
-- end
-- -- hs.hotkey.bind({"alt"}, "tab", focusNextDisplay)
