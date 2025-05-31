local scene = Scene(Sti("assets/maps/room.lua"), {})

table.insert(scene.entities, ReusableEntities.door(24, 30, 32, 32, "testScene", 23, 6))
table.insert(scene.entities, ReusableEntities.label(31, 23, 16, 32, "a chair."))
table.insert(scene.entities, ReusableEntities.label(26, 22, 16, 16, "nails."))
table.insert(scene.entities, ReusableEntities.label(18, 22, 16, 16, "nails."))



return scene