Scene = Class{}

function Scene:init(map, entities)
    self.map = map
    self.entities = entities or {}
    self.camera = {
        x = 0,
        y = 0,
        weight = 8,
        edgeBorder = 16
    }
end

function Scene:update(dt)
    -- update camera
    local playerCenterX = Player.entity.hitbox.x + Player.entity.hitbox.w/2
    local playerCenterY = Player.entity.hitbox.y + Player.entity.hitbox.h/2

    local dCamX = ((playerCenterX-GameWidth/2) - self.camera.x) * self.camera.weight * dt
    local dCamY = ((playerCenterY-GameHeight/2) - self.camera.y) * self.camera.weight * dt

    --smooth movement when getting to an edge
    local bW = 0.8
    local bA = 1-bW

    if self.camera.y < self.camera.edgeBorder then
        local mult = ((self.camera.y/self.camera.edgeBorder)*bW+bA)
        if dCamY < 0 then
            dCamY = dCamY * mult
        end
    end
    if self.camera.y + GameHeight > self.map.height*MapTileSize - self.camera.edgeBorder then
        local mult = ((((self.map.height*MapTileSize)-(self.camera.y + GameHeight))/self.camera.edgeBorder)*bW+bA)
        if dCamY > 0 then
            dCamY = dCamY * mult
        end
    end
    if self.camera.x < self.camera.edgeBorder then
        local mult = ((self.camera.x/self.camera.edgeBorder)*bW+bA)
        if dCamX < 0 then
            dCamX = dCamX * mult
        end
    end
    if self.camera.x + GameWidth > self.map.width*MapTileSize - self.camera.edgeBorder then
        local mult = ((((self.map.width*MapTileSize)-(self.camera.x + GameWidth))/self.camera.edgeBorder)*bW+bA)
        if dCamX > 0 then
            dCamX = dCamX * mult
        end
    end


    self.camera.x = self.camera.x + dCamX
    self.camera.y = self.camera.y + dCamY

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

    for k, v in pairs(self.entities) do
        self.entities[k]:update(dt)
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
    if(#self.entities > 0) then
        local drawOrder = self.entities

        table.sort(drawOrder, function(a, b)
            return a.entity.hitbox.y+a.entity.hitbox.h < b.entity.hitbox.y+b.entity.hitbox.h
        end)

        --make all entities indexed
        local addIndicies = {}
        local k = 1
        for _, v in pairs(drawOrder) do
            addIndicies[k] = v
            k = k + 1
        end
        drawOrder = addIndicies

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
    else
        Player:draw()
    end
    
end