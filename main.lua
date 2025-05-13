--dependencies
local push = require('libraries/push')
local sti = require('libraries/sti')
Lovebird = require("libraries/lovebird")
Class = require("libraries/Class")
Anim8 = require("libraries/anim8")

local setup = require("functions/setup")
TileConvert = require("functions/TileConvert")

require("classes/Entity")

Debug = false

local tempPlayer = Entity(10, 10, 32, 32, 0, 0)


function love.load()
    --load any assets
    love.graphics.setDefaultFilter("nearest", "nearest")
    setup.SetupWindow()

    CurrentMap = sti("assets/maps/testMap.lua")
    MapTileSize = 32


    
    ---
    tempPlayer.spriteSheet = love.graphics.newImage("assets/player/playerSprite.png")
    tempPlayer.animationGrid = Anim8.newGrid(32, 32, tempPlayer.spriteSheet:getWidth(), tempPlayer.spriteSheet:getHeight())
    
    tempPlayer.animations[1] = Anim8.newAnimation(tempPlayer.animationGrid('1-2',1), 0.1)

    Lovebird.print(tempPlayer.animations[1])
end
 
function love.update(dt)
    Lovebird.update()
    
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