local testScene = Scene(Sti("assets/maps/testMapFixed.lua"), {})


testScene.entities[#testScene.entities + 1] = ReusableEntities.shack(20, 1)
testScene.entities[#testScene.entities + 1] = ReusableEntities.beachSign(19, 5, "This is house number 1, where the windows blink like tired eyes, a clock ticks louder than the silence, and though no one lives here anymore - someone always watches.")


testScene.entities[#testScene.entities + 1] = ReusableEntities.shack(11, 18)
testScene.entities[#testScene.entities + 1] = ReusableEntities.beachSign(17, 22, "i am a sign")


return testScene