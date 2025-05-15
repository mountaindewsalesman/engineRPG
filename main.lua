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

Debug = false


Camera = {
    x = 0,
    y = 0,
    weight = 0.95
 }

function love.load()
    --load any assets
    love.graphics.setDefaultFilter("nearest", "nearest")
    setup.SetupWindow()

    CurrentMap = sti("assets/maps/testMap.lua")
    MapTileSize = 32


    
    ---
    

end
 
function love.update(dt)
    Lovebird.update()
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
    push:finish()

end

function love.resize(w, h)
    push:resize(w, h)
end

