local setup = {}
local push = require("libraries/push")

function setup.SetupWindow()
    local gameWidth, gameHeight = 640, 360 
    local windowWidth, windowHeight = love.window.getDesktopDimensions()
    windowWidth = windowWidth/2
    windowHeight = windowHeight/2
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true, stretched = false, pixelperfect = false})
end
return setup
-- setup screen

