local setup = {}
local push = require("libraries/push")

function setup.SetupWindow()
    local gameWidth, gameHeight = 320, 180 
    local windowWidth, windowHeight = love.window.getDesktopDimensions()
    windowWidth = windowWidth/2
    windowHeight = windowHeight/2
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true, stretched = false, pixelperfect = true})
end
return setup
-- setup screen

