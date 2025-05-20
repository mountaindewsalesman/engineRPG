TextBox = {}

TextBox.drawingText = true
TextBox.progress = 0
TextBox.text = ""

function TextBox:draw()
    if TextBox.drawingText then
        UI.menuRectangle(100, 100, 300, 100)
        love.graphics.print("SUPER COOL THING I DID", 103, 103)
    end
end