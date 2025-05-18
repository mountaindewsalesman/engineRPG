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

function Scene:draw()
    if Debug then
        CurrentScene.map:draw()
    else 
        for i, layer in ipairs(CurrentScene.map.layers) do
        
            if i ~= #CurrentScene.map.layers then
                layer:draw()
            end
        end
    end

    -- draw entities
    local drawOrder = self.entities

    table.sort(drawOrder, function(a, b)
        return a.entity.hitbox.y+a.entity.hitbox.h < b.entity.hitbox.y+b.entity.hitbox.h
    end)

    --if player is higher than all entities
    local aPlayerY = Player.entity.hitbox.y + Player.entity.hitbox.h
    if aPlayerY < drawOrder[1].entity.hitbox.y + drawOrder[1].entity.hitbox.h then
        Player:draw()
    end

    for i=1, #drawOrder do
        drawOrder[i].entity:draw()

        --sort player drawing
        local prev = drawOrder[i]
        local prevY = prev.entity.hitbox.y + prev.entity.hitbox.h or -math.huge
        local next = drawOrder[i + 1]
        local nextY = next and (next.entity.hitbox.y + next.entity.hitbox.h) or math.huge

        local playerY = Player.entity.hitbox.y + Player.entity.hitbox.h
        if(playerY > prevY and playerY < nextY) then
            Player:draw()
        end

    end
end