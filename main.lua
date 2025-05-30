--dependencies
local push = require('libraries/push')
Sti = require('libraries/sti')
Lovebird = require("libraries/lovebird")
Class = require("libraries/Class")
Anim8 = require("libraries/anim8")

require("functions/Setup")
require("functions/Rect")
UI = require("functions/UI")
require("functions/Inputs")
require("functions/textBox")
require("functions/TileConvert")

require("classes/player")
require("classes/scene")

require("classes/entity")
require("classes/entities/entityStatic")
require("classes/entities/entitySign")
require("classes/entities/entityPortal")

ReusableEntities = require("scenes/reusableEntities")

Debug = false
MapTileSize = 16

function love.load()
    CurrentScene = require("scenes/testScene")
    --load any assets
    love.graphics.setDefaultFilter("nearest", "nearest")
    Setup.setupWindow()

    
    Setup.setupPlayer()    
    ---
    
    --TextBox:beginText("On the edge of a forgotten coastline stood a lighthouse, tall and weathered by time, where the sea clawed endlessly at jagged rocks below. The villagers called it Blackmere Light, and it hadn't shone for nearly a decade - until one stormy evening, it came back to life.")
end
 
function love.update(dt)
    Lovebird.update()

    GetInputs:update()
    TextBox:update(dt)
    CurrentScene:update(dt)
    Player:update(dt)
    
end

function love.draw()
    
    push:start()

        love.graphics.push()
        love.graphics.translate(math.floor(-CurrentScene.camera.x+0.5), math.floor(-CurrentScene.camera.y+0.5))

            CurrentScene:draw()
        love.graphics.pop()

        
        TextBox:draw()
    
    push:finish()

end

function love.resize(w, h)
    push:resize(w, h)
end

