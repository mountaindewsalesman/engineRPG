-- setup screen
local push = require 'libraries/push'
local gameWidth, gameHeight = 320, 180 
local windowWidth, windowHeight = love.window.getDesktopDimensions()
push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})

function love.load()
    
end

function love.draw()
    push:start()

    push:finish()
end
