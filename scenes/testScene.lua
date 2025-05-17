local testScene = Scene(Sti("assets/maps/testMapFixed.lua"), {})

local loadingEntity = Entity(100, 100, 10, 10, false)
loadingEntity.spriteSheet = love.graphics.newImage("assets/entities/Shack.png")
loadingEntity.animationGrid = Anim8.newGrid(96, 96, loadingEntity.spriteSheet:getWidth(), loadingEntity.spriteSheet:getHeight())
loadingEntity.animations[#loadingEntity.animations+1] = Anim8.newAnimation(loadingEntity.animationGrid('1-1', 1), 99999999999999999999)
--local testStatic = EntityStatic(loadingEntity)

--testScene.entities.insert(testStatic)
return testScene