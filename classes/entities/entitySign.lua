EntitySign = Class{}

function EntitySign:init(entity, text, speed)
    self.entity = entity
    self.text = text or "nil"
    self.currentBox = 0
    self.speed = speed or 25
end

function EntitySign:draw()
    self.entity:draw()
end

function EntitySign:update(dt)

    self.entity:update(dt)
    if Rect.colliding(self.entity.hitbox, Player.interact) then

        if type(self.text) == "table" then
            --table case

            if self.currentBox == 0 then
                if GetInputs.tap("select") then
                    self.currentBox =  1
                    TextBox:beginText(self.text[self.currentBox], self.speed)
                end
            else 

                if not TextBox.drawingText then
                    self.currentBox = self.currentBox + 1
                    if self.currentBox > #self.text then
                        self.currentBox = 0
                        TextBox.drawingText = false
                    else
                        TextBox:beginText(self.text[self.currentBox], self.speed)
                    end
                end
            end
        else
            if GetInputs.tap("select") and not TextBox.drawingText then

                TextBox:beginText(self.text, self.speed)
            end    
        end



    end
end