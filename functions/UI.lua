local gameFont = love.graphics.newFont("assets/gamefont.ttf", 16)
love.graphics.setFont(gameFont)


local UI = {}

UI.border = 2
UI.thickness = 1
function UI.menuRectangle(x, y, w, h)


    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", x, y, w, h)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", x+UI.border, y+UI.border, w-2*UI.border, h-2*UI.border)

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", x+UI.border+UI.thickness, y+UI.border+UI.thickness, w-2*(UI.border+UI.thickness), h-2*(UI.border+UI.thickness))
    love.graphics.setColor(1, 1, 1)
end
return UI