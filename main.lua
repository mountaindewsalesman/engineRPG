--dependencies
local push = require('libraries/push')
Sti = require('libraries/sti')
Lovebird = require("libraries/lovebird")
Class = require("libraries/Class")
Anim8 = require("libraries/anim8")

Setup = require("functions/Setup")
Rect = require("functions/Rect")
UI = require("functions/UI")
GetInputs = require("functions/Inputs")
TextBox = require("functions/TextBox")
TileConvert = require("functions/TileConvert")
ScreenEffect = require("functions/ScreenEffect")

require("classes/player")
require("classes/scene")

require("classes/entity")
require("classes/entities/entityStatic")
require("classes/entities/entitySign")
require("classes/entities/entityPortal")

ReusableEntities = require("assets/scenes/reusableEntities")

Debug = false
GamePaused = false
MapTileSize = 16

function love.load()
    CurrentScene = require("assets/scenes/testScene")
    --load any assets
    love.graphics.setDefaultFilter("nearest", "nearest")
    Setup.setupWindow()

    
    Setup.setupPlayer()        
end
 
function love.update(dt)
    Lovebird.update()
    GetInputs:update()

    TextBox:update(dt)
    local gameDT = dt*ScreenEffect.dtMult
    GamePaused = (gameDT == 0)

    CurrentScene:update(gameDT)
    Player:update(gameDT)


    ScreenEffect:update(dt)
    
end

function love.draw()
    
    push:start()

        love.graphics.push()
        love.graphics.translate(math.floor(-CurrentScene.camera.x+0.5), math.floor(-CurrentScene.camera.y+0.5))

            CurrentScene:draw()

        love.graphics.pop()

        ScreenEffect:draw()
        TextBox:draw()
    
    push:finish()

end

function love.resize(w, h)
    push:resize(w, h)
end

