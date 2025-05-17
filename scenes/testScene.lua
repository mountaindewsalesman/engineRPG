local testScene = Scene(Sti("assets/maps/testMapFixed.lua"), {})


testScene.entities[#testScene.entities + 1] = ReusableEntities.shack(300, 100)
testScene.entities[#testScene.entities + 1] = ReusableEntities.shack(380, 120)
return testScene