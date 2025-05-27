EntityPortal = Class{}

-- if preserveXOff or PreserveYOff is not false, the entity will be moved to their x or y position + preserveXOff or preserveYOff
function EntityPortal:init(entity, needsInteract, outX, outY, preserveXOff, preserveYOff)
    self.entity = entity
    self.needsInteract = needsInteract or false
    self.outX = outX or 32
    self.outY = outY or 32
    self.preserveOffX = preserveXOff or false
    self.preserveOffY = preserveYOff or false
end

function EntityPortal:draw()
    self.entity:draw()
end

function EntityPortal:update(dt)
    self.entity:update(dt)
end