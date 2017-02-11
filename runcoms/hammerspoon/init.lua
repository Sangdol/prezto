-- http://www.hammerspoon.org/go/
-- https://learnxinyminutes.com/docs/lua/

hs.hotkey.bind({"cmd", "ctrl"}, "c", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + 20
  f.y = max.y + 40
  f.w = max.w - 40
  f.h = max.h - 60
  win:setFrame(f)
end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
