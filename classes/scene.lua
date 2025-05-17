Scene = Class{}

function Scene:init(map, entities)
    self.map = map
    self.entities = entities or {}
    self.camera = {
        x = 0,
        y = 0,
        weight = 0.95
    }
end

function Scene:update(dt)
    -- update camera
    --self.camera.x = self.camera.x + (self.entities[1].x - self.camera.x) * self.camera.weight
    --self.camera.y = self.camera.y + (self.entities[1].y - self.camera.y) * self.camera.weight

    -- update entities
    for i=1, #self.entities do
        self.entities[i]:update(dt)
    end
end