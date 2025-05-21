Scene = Class{}

function Scene:init(map, entities)
    self.map = map
    self.entities = entities or {}
    self.camera = {
        x = 0,
        y = 0,
        weight = 8
    }
end

function Scene:update(dt)
    -- update camera
    local playerCenterX = Player.entity.hitbox.x + Player.entity.hitbox.w/2
    local playerCenterY = Player.entity.hitbox.y + Player.entity.hitbox.h/2

    self.camera.x = self.camera.x + ((playerCenterX-GameWidth/2) - self.camera.x) * self.camera.weight * dt
    self.camera.y = self.camera.y + ((playerCenterY-GameHeight/2) - self.camera.y) * self.camera.weight * dt

    -- clamp camera to map bounds

    if self.camera.x < 0 then
        self.camera.x = 0
    end
    if self.camera.y < 0 then
        self.camera.y = 0
    end
    if self.camera.x > self.map.width*MapTileSize - GameWidth then
        self.camera.x = self.map.width*MapTileSize - GameWidth
    end
    if self.camera.y > self.map.height*MapTileSize - GameHeight then
        self.camera.y = self.map.height*MapTileSize - GameHeight
    end
    --self.camera.y = self.camera.y + (self.entities[1].y - self.camera.y) * self.camera.weight

    for i=1, #self.entities do
        self.entities[i]:update(dt)
    end
end

function Scene:draw()
    if Debug then
        CurrentScene.map:draw(math.floor(-CurrentScene.camera.x+0.5), math.floor(-CurrentScene.camera.y+0.5))
    else 
        for i, layer in ipairs(CurrentScene.map.layers) do
        
            if i ~= #CurrentScene.map.layers then
                layer:draw(math.floor(-CurrentScene.camera.x+0.5), math.floor(-CurrentScene.camera.y+0.5))
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