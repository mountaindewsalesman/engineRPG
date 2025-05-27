PlayerClass = Class{}

function PlayerClass:init(entity, accel, maxSpeed, friction, inventory, direction)
    --entity:x, y, w, h, xVel, yVel, collides, spriteOffX, spriteOffY, direction)
    self.entity = Entity(20, 20, 12, 12, 0, 0, true, 10, 18, 1)
    self.entity.spriteSheet = love.graphics.newImage("assets/player/Player.png")
    self.entity.animationGrid =  Anim8.newGrid(32, 32, self.entity.spriteSheet:getWidth(), self.entity.spriteSheet:getHeight())

    self.entity.animations[#self.entity.animations+1] = Anim8.newAnimation(self.entity.animationGrid('1-4', 1), 0.2)
    self.entity.animations[#self.entity.animations+1] = Anim8.newAnimation(self.entity.animationGrid('1-8', 2), 0.1)

    self.entity.animations[#self.entity.animations+1] = Anim8.newAnimation(self.entity.animationGrid('1-4', 3), 0.2)
    self.entity.animations[#self.entity.animations+1] = Anim8.newAnimation(self.entity.animationGrid('1-8', 5), 0.1)

    self.entity.animations[#self.entity.animations+1] = Anim8.newAnimation(self.entity.animationGrid('1-4', 4), 0.2)
    self.entity.animations[#self.entity.animations+1] = Anim8.newAnimation(self.entity.animationGrid('1-8', 6), 0.1)


    self.accel = accel or 10
    self.maxSpeed = maxSpeed or 5
    self.friction = friction or 0.9
    self.inventory = inventory or {}

    self.interact = {x = self.entity.hitbox.x+15*self.entity.direction, y = self.entity.hitbox.y, w = 12, h = 12}

    self.direction = {x = 1, y = 0}
end

function PlayerClass:movement(dt)
    local frameRef = 60

    local movVector = {x = 0, y = 0}

    if GetInputs.held("up") then
        movVector.y = movVector.y - 1

        self.direction.x = 0
        self.direction.y = 1
    end
    if GetInputs.held("down") then
        movVector.y = movVector.y + 1

        self.direction.x = 0
        self.direction.y = -1
    end
    if GetInputs.held("right") then
        movVector.x = movVector.x + 1

        self.direction.x = 1
        self.direction.y = 0
    end
    if GetInputs.held("left") then
        movVector.x = movVector.x - 1

        self.direction.x = -1
        self.direction.y = 0
    end    

    --normalize speed
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

    --animations
    if self.direction.x == 1 or self.direction.x == 0 then
        self.entity.direction = 1
    else
        self.entity.direction = -1
    end

    if(movVector.x ~= 0 or movVector.y ~= 0) then
        if self.direction.y == 0 then
            self.entity.currentAnimation = 2
        elseif self.direction.y == 1 then
            self.entity.currentAnimation = 6
        elseif self.direction.y == -1 then
            self.entity.currentAnimation = 4
        end
    else
        if self.direction.y == 0 then
            self.entity.currentAnimation = 1
        elseif self.direction.y == 1 then
            self.entity.currentAnimation = 5
        elseif self.direction.y == -1 then
            self.entity.currentAnimation = 3
        end
    end
end

function PlayerClass:draw()
    --called from map class when positon in sorting
    self.entity:draw()

    if Debug then
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("line", self.interact.x, self.interact.y, self.interact.w, self.interact.h)
        love.graphics.setColor(1, 1, 1)
    end
end

function PlayerClass:update(dt)
    
    self:movement(dt)
    self.interact = {x = self.entity.hitbox.x+15*self.direction.x, y = self.entity.hitbox.y-15*self.direction.y, w = 12, h = 12}
    self.entity:update(dt)
    
end