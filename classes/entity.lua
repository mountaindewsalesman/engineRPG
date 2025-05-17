Entity = Class{}

function Entity:init(x, y, w, h, xVel, yVel, collides, spriteOffX, spriteOffY, direction)
    self.x = x or 0
    self.y = y or 0
    self.w = w or 32
    self.h = h or 32
    self.xVel = xVel or 0
    self.yVel = yVel or 0 

    self.animations = {}
    self.currentAnimation = 1
    self.spriteSheet = 0
    self.animationGrid = 0
    
    self.spriteOffX = spriteOffX or 0
    self.spriteOffY = spriteOffY or 0
    self.direction = direction or 1

    self.collides = collides or false
    self.hitbox = {x = x, y = y, w = w, h = h}

    self.gridFlipTranslation = 0
end

function Entity:update(dt)
    --update hitbox 
    self.hitbox = {x = self.x, y = self.y, w = self.w, h = self.h}

    --update animations
    self.animations[self.currentAnimation]:update(dt)

    --update sprite drawing
    if self.direction == -1 then
        local quad = self.animations[self.currentAnimation].frames[self.animations[self.currentAnimation].position]
        local x, y, w, h = quad:getViewport()
        self.gridFlipTranslation = w
    else
        self.gridFlipTranslation = 0
    end

    --update position

    local futureX = self.x + self.xVel * dt
    local futureY = self.y + self.yVel * dt

    -- update hitbox for futureX check
    self.x = futureX
    self.hitbox.x = self.x
    if self:collidesMap() and self.collides then
        -- step back pixel by pixel until no longer colliding
        while self:collidesMap() do
            self.x = self.x + (self.xVel > 0 and -0.1 or 0.1)
            self.hitbox.x = self.x
        end
        self.xVel = 0
    end

    -- update hitbox for futureY check
    self.y = futureY
    self.hitbox.y = self.y
    if self:collidesMap() and self.collides then
        while self:collidesMap() do
            self.y = self.y + (self.yVel > 0 and -0.1 or 0.1)
            self.hitbox.y = self.y
        end
        self.yVel = 0
    end

end

function Entity:draw()
    if #self.animations > 0 then
        self.animations[self.currentAnimation]:draw(self.spriteSheet, math.floor(self.x+0.5)+self.spriteOffX+self.gridFlipTranslation, math.floor(self.y)+self.spriteOffY, 0, self.direction, 1)
    end

    if Debug then
        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    end
end

function Entity:collidesMap()

    local tileX = TileConvert.pixToTile(self.x+(self.w/2), self.y+(self.h/2))[1] + 1
    local tileY = TileConvert.pixToTile(self.x+(self.w/2), self.y+(self.h/2))[2] + 1

    local props
    
    local collides = false
    
    local xVals = {-1, 0, 1, -1, 1, -1, 0, 1}
    local yVals = {-1, -1, -1, 0, 0, 1, 1, 1}

    for i = 1, #xVals do
        local x = xVals[i]
        local y = yVals[i]
        
        props = CurrentScene.map:getTileProperties(#CurrentScene.map.layers, tileX+x, tileY+y)

        
        if(props.collides and props.collides == "true") then
            if Rect.colliding(self.hitbox, {x = (tileX+x-1)*MapTileSize, y = (tileY+y-1)*MapTileSize, w = MapTileSize, h = MapTileSize}) then
                collides = true
                break
            end
        end
    end

    

    return collides
        
end