PlayerClass = Class{}

function PlayerClass:init(entity, accel, maxSpeed, friction, inventory)
    --Entity:init(x, y, w, h, xVel, yVel, true, animations, currentAnimation)
    self.entity = entity
    self.entity.spriteSheet = love.graphics.newImage("assets/player/Player.png")
    self.entity.animationGrid =  Anim8.newGrid(32, 32, self.entity.spriteSheet:getWidth(), self.entity.spriteSheet:getHeight())
    self.entity.animations[#self.entity.animations+1] = Anim8.newAnimation(self.entity.animationGrid('1-4', 1), 0.2)
    self.entity.animations[#self.entity.animations+1] = Anim8.newAnimation(self.entity.animationGrid('1-4', 2), 0.15)

    self.accel = accel or 10
    self.maxSpeed = maxSpeed or 5
    self.friction = friction or 0.9
    self.inventory = inventory or {}
end

function PlayerClass:movement()

end

function PlayerClass:draw()
    --called from map class when positon in sorting
    self.entity:draw()
end

function PlayerClass:update(dt)
    local frameRef = 60
    --get inputs
    local movVector = {x = 0, y = 0}
    if love.keyboard.isDown("right") then
        movVector.x = movVector.x + 1
        self.entity.direction = 1
    end
    if love.keyboard.isDown("left") then
        movVector.x = movVector.x - 1
        self.entity.direction = -1
    end
    if love.keyboard.isDown("up") then
        movVector.y = movVector.y - 1
    end
    if love.keyboard.isDown("down") then
        movVector.y = movVector.y + 1
    end
    if (movVector.x ~= 0 and movVector.y ~= 0) then
        movVector.x = movVector.x * 0.707
        movVector.y = movVector.y * 0.707
    end

    --add accel to vel
    self.entity.xVel = self.entity.xVel + (movVector.x * self.accel*dt*frameRef)
    self.entity.yVel = self.entity.yVel + (movVector.y * self.accel*dt*frameRef)

    --cap speed
    if(math.sqrt(self.entity.xVel^2 + self.entity.yVel^2) > self.maxSpeed) then
        local angle = math.atan2(self.entity.yVel, self.entity.xVel)
        self.entity.xVel = math.cos(angle) * self.maxSpeed
        self.entity.yVel = math.sin(angle) * self.maxSpeed
    end

    --apply friction
    self.entity.xVel = self.entity.xVel * math.pow(self.friction, dt*frameRef)
    self.entity.yVel = self.entity.yVel * math.pow(self.friction, dt*frameRef)

    self.entity:update(dt)

    --update animations
    if(movVector.x ~= 0 or movVector.y ~= 0) then
        self.entity.currentAnimation = 2
    else
        self.entity.currentAnimation = 1
    end

end