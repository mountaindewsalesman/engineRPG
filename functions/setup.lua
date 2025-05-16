local setup = {}
local push = require("libraries/push")

function setup.SetupWindow()
    local gameWidth, gameHeight = 480, 270 
    local windowWidth, windowHeight = love.window.getDesktopDimensions()
    windowWidth = windowWidth/2
    windowHeight = windowHeight/2
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true, stretched = false, pixelperfect = false})
end

function setup.setupPlayer()
    local playerEntity = Entity(50, 50, 10, 10, 0, 0, true, -11, -22, 1)
    Player = PlayerClass(playerEntity, 100000, 100, 0.000001, {})
    Player.entity.direction = -1
end
return setup
-- setup screen

