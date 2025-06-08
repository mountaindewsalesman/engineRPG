--text is initialized using beginText command. draw and update are called on every frame, but only sometiems do somthing
local TextBox = {}

TextBox.drawingText = false
TextBox.progress = 0
TextBox.text = ""
TextBox.subString = ""
TextBox.maxTextWidth = 0
TextBox.speed = 25

local boxSize = 0.30

function TextBox:draw()
    if TextBox.drawingText then
        local boxX = 3
        local boxY = math.floor(GameHeight*(1-boxSize))
        local boxW = GameWidth-6
        local boxH = math.floor(GameHeight*boxSize)-3

        UI.menuRectangle(boxX, boxY, boxW, boxH)

        love.graphics.printf(TextBox.subString, 5+boxX+UI.thickness, boxY+UI.thickness+1, boxW-UI.thickness-8, "left")
    end
end

function TextBox:update(dt)
    if TextBox.drawingText then
        TextBox.progress = TextBox.progress + dt
        if TextBox.subString ~= TextBox.text:sub(1, math.floor(TextBox.progress*TextBox.speed)) then
            TextBox.subString = TextBox.text:sub(1, math.floor(TextBox.progress*TextBox.speed))
            --play sound
        end
        if GetInputs.tap("exit") then
            if TextBox.subString == TextBox.text then
                TextBox.drawingText = false
            else
                TextBox.progress = #TextBox.text / TextBox.speed
                TextBox.subString = TextBox.text
            end
        end
        
    end
end


function TextBox:beginText(text, speed, name, sound)
    if(not TextBox.drawingText) then
        TextBox.drawingText = true
        TextBox.progress = 0
        TextBox.text = text
        TextBox.subString = ""
        
        TextBox.speed = speed or 25
    end
end


return TextBox

