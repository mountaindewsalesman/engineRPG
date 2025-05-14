--dependencies
local push = require('libraries/push')
local sti = require('libraries/sti')
Lovebird = require("libraries/lovebird")
Class = require("libraries/Class")
Anim8 = require("libraries/anim8")

local setup = require("functions/setup")
TileConvert = require("functions/TileConvert")
Rect = require("functions/Rect")

require("classes/Entity")

Debug = true

local tempPlayer = Entity(50, 50, 30, 30, 0, 0, true)


function love.load()
    --load any assets
    love.graphics.setDefaultFilter("nearest", "nearest")
    setup.SetupWindow()

    CurrentMap = sti("assets/maps/testMap.lua")
    MapTileSize = 32


    
    ---
    tempPlayer.spriteSheet = love.graphics.newImage("assets/player/playerSprite.png")
    tempPlayer.animationGrid = Anim8.newGrid(32, 32, tempPlayer.spriteSheet:getWidth(), tempPlayer.spriteSheet:getHeight())
    tempPlayer.animations[1] = Anim8.newAnimation(tempPlayer.animationGrid('1-2',1), 0.5)

end
 
function love.update(dt)
    Lovebird.update()

    tempPlayer.yVel = 0
    if love.keyboard.isDown("up") then
        tempPlayer.yVel = tempPlayer.yVel - 150
    elseif love.keyboard.isDown("down") then
        tempPlayer.yVel = tempPlayer.yVel + 150
    end

    tempPlayer.xVel = 0
    if love.keyboard.isDown("left") then
        tempPlayer.xVel = tempPlayer.xVel - 150
    elseif love.keyboard.isDown("right") then
        tempPlayer.xVel = tempPlayer.xVel + 150
    end

    tempPlayer:update(dt)

end

function love.draw()
    
    push:start()
        if Debug then
            CurrentMap:draw()
        else 
            for i, layer in ipairs(CurrentMap.layers) do
            
                if i ~= #CurrentMap.layers then
                    layer:draw()
                end
            end
        end
        
    tempPlayer:draw()
    push:finish()

end

function love.resize(w, h)
    push:resize(w, h)
end