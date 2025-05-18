EntityInteract = Class{}

function EntityInteract:init(entity, event)
    self.entity = entity
    self.entity.event = event
end

function EntityInteract:draw()
    self.entity:draw()
end

function EntityInteract:update(dt)
    self.entity:update(dt)
    if Rect.collideing(Player.interact, self.entity.hitbox) then
        self.event(self)
    end
end