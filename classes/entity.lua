Entity = Class{}

function Entity:init(x, y, w, h, xVel, yVel, animations, currentAnimation, collides)
    self.x = x or 0
    self.y = y or 0
    self.w = w or 32
    self.h = h or 32
    self.xVel = xVel or 0
    self.yVel = yVel or 0 

    self.animations = animations or {}
    self.currentAnimation = currentAnimation or 1
    self.collides = collides or false

    self.spriteSheet = 0
    self.animationGrid = 0

    self.hitbox = {x, y, w, h}
end

function Entity:update(dt)
    self.animations[self.currentAnimation]:update(dt)

    --finish collision detection
    if(not(self.xVel) == 0 and not(self.yVel == 0)) then
        self.x = self.x + (self.y * dt)
        --Lovebird.print(TileConvert.pixToTile(self.x, self.y))
        --collision

        self.y = self.y + (self.y * dt)
        --collision
    end
end

function Entity:draw()
    if #self.animations > 0 then
        self.animations[1]:draw(self.spriteSheet, 100, 100)
    end

    if Debug then
        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
    end
end