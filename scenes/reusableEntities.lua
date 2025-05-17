local entities = {}

--x. y, w, h, xv, yv, collides, spriteOffX, spriteOffY
function entities.shack(x, y)
    local loadingEntity = Entity(x, y, 15, 20, 0, 0, false, -60, -70)
    loadingEntity.spriteSheet = love.graphics.newImage("assets/entities/Shack.png")
    loadingEntity.animationGrid = Anim8.newGrid(96, 96, loadingEntity.spriteSheet:getWidth(), loadingEntity.spriteSheet:getHeight())
    loadingEntity.animations[#loadingEntity.animations+1] = Anim8.newAnimation(loadingEntity.animationGrid('1-1', 1), math.huge)
    return EntityStatic(loadingEntity)
end




return entities