EntityStatic = Class{}

function EntityStatic:init(entity)
    self.entity = entity
end

function EntityStatic:draw()
    self.entity:draw()
end

function EntityStatic:update(dt)
    self.entity:update(dt)
end