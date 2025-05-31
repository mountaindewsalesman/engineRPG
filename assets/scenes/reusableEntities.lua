local entities = {}

--x. y, w, h, xv, yv, collides, spriteOffX, spriteOffY
function entities.shack(x, y)
    local loadingEntity = Entity(x*MapTileSize, y*MapTileSize, 15, 20, 0, 0, false, 60, 70)
    loadingEntity.spriteSheet = love.graphics.newImage("assets/entities/Shack.png")
    loadingEntity.animationGrid = Anim8.newGrid(96, 96, loadingEntity.spriteSheet:getWidth(), loadingEntity.spriteSheet:getHeight())
    loadingEntity.animations[#loadingEntity.animations+1] = Anim8.newAnimation(loadingEntity.animationGrid('1-1', 1), math.huge)
    return EntityStatic(loadingEntity)
end

function entities.beachSign(x, y, text)
    local loadingEntity = Entity(x*MapTileSize, y*MapTileSize, 16, 16, 0, 0, false, 0, 0)
    loadingEntity.spriteSheet = love.graphics.newImage("assets/entities/sign.png")
    loadingEntity.animationGrid = Anim8.newGrid(16, 16, loadingEntity.spriteSheet:getWidth(), loadingEntity.spriteSheet:getHeight())
    loadingEntity.animations[#loadingEntity.animations+1] = Anim8.newAnimation(loadingEntity.animationGrid('1-1', 1), math.huge)
    return EntitySign(loadingEntity, text)
end
--other types of signs too


function entities.label(x, y, w, h, text)
    local loadingEntity = Entity(x*MapTileSize, y*MapTileSize, w, h, 0, 0, false, 0, 0)
    return EntitySign(loadingEntity, text)
end

function entities.door(x, y, w, h, output, outX, outY)
    local loadingEntity = Entity(x*MapTileSize, y*MapTileSize, w, h, 0, 0, false, 0, 0)
    return EntityPortal(loadingEntity, true, output, outX*MapTileSize, outY*MapTileSize)
end


return entities