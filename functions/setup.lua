local Setup = {}
local push = require("libraries/push")

---@diagnostic disable-next-line: duplicate-set-field
function Setup.setupWindow()
    GameWidth, GameHeight = 480, 270 
    local windowWidth, windowHeight = love.window.getDesktopDimensions()
    windowWidth = windowWidth*0.75
    windowHeight = windowHeight*0.75
    push:setupScreen(GameWidth, GameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true, stretched = false, pixelperfect = true, vsync = true})
end

---@diagnostic disable-next-line: duplicate-set-field
function Setup.setupPlayer() 
    local playerEntity = Entity(50, 50, 12, 12, 0, 0, true, -9, -20, 1)
    Player = PlayerClass(playerEntity, 100, 130, 0.70, {})
    Player.entity.direction = -1
end
-- setup screen

return Setup