local setup = {}
local push = require("libraries/push")

function setup.SetupWindow()
    local gameWidth, gameHeight = 480, 270 
    local windowWidth, windowHeight = love.window.getDesktopDimensions()
    windowWidth = windowWidth/2
    windowHeight = windowHeight/2
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true, stretched = false, pixelperfect = true})
end

function setup.setupPlayer()
    local playerEntity = Entity(50, 50, 12, 12, 0, 0, true, -9, -20, 1)
    Player = PlayerClass(playerEntity, 100, 130, 0.70, {})
    Player.entity.direction = -1
end
return setup
-- setup screen

