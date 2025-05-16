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
require("classes/player")

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
    setup.setupPlayer()    
    ---
    

end
 
function love.update(dt)
    Lovebird.update()
    Player:update(dt)
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
    
        Player:draw()
    push:finish()

end

function love.resize(w, h)
    push:resize(w, h)
end

