--dependencies
local push = require('libraries/push')
Sti = require('libraries/sti')
Lovebird = require("libraries/lovebird")
Class = require("libraries/Class")
Anim8 = require("libraries/anim8")

local setup = require("functions/Setup")
TileConvert = require("functions/TileConvert")
Rect = require("functions/Rect")
require("functions/Inputs")

require("classes/player")
require("classes/scene")

require("classes/entity")
require("classes/entityStatic")

ReusableEntities = require("scenes/reusableEntities")

Debug = true
MapTileSize = 16

function love.load()
    CurrentScene = require("scenes/testScene")
    --load any assets
    love.graphics.setDefaultFilter("nearest", "nearest")
    setup.SetupWindow()

    
    setup.setupPlayer()    
    ---
    

end
 
function love.update(dt)
    Lovebird.update()

    GetInputs.update()
    Player:update(dt)
end

function love.draw()
    
    push:start()
    CurrentScene:draw()
    push:finish()

end

function love.resize(w, h)
    push:resize(w, h)
end

