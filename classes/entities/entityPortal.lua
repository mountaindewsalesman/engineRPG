EntityPortal = Class{}

-- if preserveXOff or PreserveYOff is not false, the entity will be moved to their x or y position + preserveXOff or preserveYOff
function EntityPortal:init(entity, needsInteract, outScene, outX, outY, preserveXOff, preserveYOff)
    self.entity = entity
    self.needsInteract = needsInteract or false
    self.outScene = outScene or "testScene"
    self.outX = outX or 32
    self.outY = outY or 32
    self.preserveOffX = preserveXOff or false
    self.preserveOffY = preserveYOff or false
    self.transitionDur = 2
end

function EntityPortal:draw()
    self.entity:draw()
end

function EntityPortal:update(dt)
    
    self.entity:update(dt)

    if Rect.colliding(self.entity.hitbox, Player.interact) and GetInputs.tap("select") and not(self.waitingForTransition) then
        ScreenEffect:addEffect("transition", self.transitionDur)
        self.waitingForTransition = true
    end 

    if self.waitingForTransition then
        if #ScreenEffect.currentEffects > 0 then
            local foundEffect = false
            for k, effect in pairs(ScreenEffect.currentEffects) do
                
                if effect.type == "transition" and effect.duration == self.transitionDur then
                    foundEffect = true
                end
                
                if effect.type == "transition" and effect.duration == self.transitionDur and effect.timeActive > effect.duration/2 then
                    self:switchScene()
                    self.waitingForTransition = false
                end
            end
            if not foundEffect then
                --no transition has been found, so it has been removed and we should switch scene anywayss. 
                self:switchScene()
                self.waitingForTransition = false
                foundEffect = true
            end
        end
    end
end

function EntityPortal:switchScene()
    CurrentScene = require("assets/scenes/" .. self.outScene)
        

    if self.preserveOffX then
        Player.entity.x = self.outX + self.preserveOffX
    else
        Player.entity.x = self.outX
    end

    if self.preserveOffY then
        Player.entity.y = self.outY + self.preserveOffY
    else
        Player.entity.y = self.outY
    end
    Player:update(0)

    local playerCenterX = Player.entity.hitbox.x + Player.entity.hitbox.w/2
    local playerCenterY = Player.entity.hitbox.y + Player.entity.hitbox.h/2

    CurrentScene.camera.x = playerCenterX - GameWidth/2
    CurrentScene.camera.y = playerCenterY - GameHeight/2

    --clamp camera
    CurrentScene:update(0)

end