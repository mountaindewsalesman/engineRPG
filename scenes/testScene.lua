local scene = Scene(Sti("assets/maps/testMapFixed.lua"), {})


table.insert(scene.entities, ReusableEntities.shack(20, 1))
table.insert(scene.entities, ReusableEntities.beachSign(19, 5, {"I am a sign number 1", "but my friends usually just call me dipshit"}))


table.insert(scene.entities, ReusableEntities.shack(11, 18))
table.insert(scene.entities, ReusableEntities.beachSign(17, 22, "i am a sign number"))

table.insert(scene.entities, ReusableEntities.label(3, 23, 32, 32, "rocks."))

table.insert(scene.entities, ReusableEntities.door(24, 6, 16, 16, "room", 24, 28))


return scene