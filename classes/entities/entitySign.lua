EntitySign = Class{}

function EntitySign:init(entity, text)
    self.entity = entity
    self.text = text or "nil"
end

function EntitySign:draw()
    self.entity:draw()
end

function EntitySign:update(dt)
    self.entity:update(dt)
    if Rect.colliding(self.entity.hitbox, Player.interact) then
        if GetInputs.tap("select") and not TextBox.drawingText then
            TextBox:beginText(self.text)
        end
    end
end