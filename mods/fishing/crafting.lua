-----------------------------------------------------------------------------------------------
-- Fishing - Mossmanikin's version - Recipes 0.0.5
-----------------------------------------------------------------------------------------------
-- original by wulfsdad (http://forum.minetest.net/viewtopic.php?id=4375)
-- this version by Mossmanikin
-- License (code & textures): 	WTFPL
-- Contains code from: 		animal_clownfish, animal_fish_blue_white, fishing (original), stoneage
-- Looked at code from:
-- Dependencies: 			default, farming
-- Supports:				animal_clownfish, animal_fish_blue_white, animal_rat, mobs
-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------
-- Fishing Pole
-----------------------------------------------------------------------------------------------
-- mc style
minetest.register_craft({
	output = "fishing:pole",
	recipe = { 
		{"", 				"",					"default:stick"	},
		{"", 				"default:stick",	"farming:string"},
		{"default:stick",	"",					"farming:string"},
	}
})

minetest.register_craft({
	output = "fishing:pole",
	recipe = { 
		{"", 				"",					"default:stick"  },
		{"", 				"default:stick",	"moreblocks:rope"},
		{"default:stick",	"",					"moreblocks:rope"},
	}
})

minetest.register_craft({
	output = "fishing:pole",
	recipe = { 
		{"", 				"",					"default:stick"	},
		{"", 				"default:stick",	"ropes:rope"   	},
		{"default:stick",	"",					"ropes:rope"   	},
	}
})


-----------------------------------------------------------------------------------------------
-- Fish
-----------------------------------------------------------------------------------------------
minetest.register_craft({
	type = "cooking",
	output = "fishing:fish",
	recipe = "fishing:fish_raw",
	cooktime = 2,
})

-----------------------------------------------------------------------------------------------
-- Sushi
-----------------------------------------------------------------------------------------------
minetest.register_craft({
	type = "shapeless",
	output = "fishing:sushi",
	recipe = {"fishing:fish_raw","flowers:seaweed"},
})

minetest.register_craft({
	type = "shapeless",
	output = "fishing:sushi",
	recipe = {"fishing:fish_raw","seaplants:leavysnackgreen"},
})

