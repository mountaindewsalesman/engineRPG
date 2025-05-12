--dependencies
local push = require('libraries/push')
local sti = require('libraries/sti')
local setup = require("functions/setup")
local currentMap

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    setup.SetupWindow()
    currentMap = sti("assets/maps/testMap.lua")
    
end

function love.draw()
    push:start()
        currentMap:draw()


        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", 100, 100, 220, 20)

    push:finish()
end

function love.resize(w, h)
    push:resize(w, h)
end