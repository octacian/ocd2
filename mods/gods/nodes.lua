minetest.register_tool("gods:staff", {
	description = "Gold Staff",
	inventory_image = "gods_tool_staff.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			magic = {times={[1]=0.5}, uses=200, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})

minetest.register_node("gods:hiro_crops", {
	description = "Hiroglifs of Crops ",
	tiles = {"gods_hiro_crops.png"},
	is_ground_content = true,
	groups = {magic=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("gods:hiro_men", {
	description = "Hiroglifs of Men ",
	tiles = {"gods_hiro_men.png"},
	is_ground_content = true,
	groups = {magic=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("gods:hiro_sun", {
	description = "Hiroglifs of Sun ",
	tiles = {"gods_hiro_sun.png"},
	is_ground_content = true,
	groups = {magic=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("gods:hiro_man_right", {
	description = "Hiroglifs of Man",
	tiles = {"gods_hiro_man_right.png"},
	is_ground_content = true,
	groups = {magic=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("gods:hiro_man_left", {
	description = "Hiroglifs of Man",
	tiles = {"gods_hiro_man_left.png"},
	is_ground_content = true,
	groups = {magic=1},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("gods:hiro_eye", {
	description = "Hiroglifs of Eye",
	tiles = {"gods_hiro_eye.png"},
	is_ground_content = true,
	groups = {magic=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("gods:hiro_earth", {
	description = "Hiroglifs of Earth",
	tiles = {"gods_hiro_earth.png"},
	is_ground_content = true,
	groups = {magic=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("gods:hiro_fire", {
	description = "Hiroglifs of Fire",
	tiles = {"gods_hiro_fire.png"},
	is_ground_content = true,
	groups = {magic=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("gods:hiro_air", {
	description = "Hiroglifs of Air",
	tiles = {"gods_hiro_air.png"},
	is_ground_content = true,
	groups = {magic=1},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("gods:hiro_water", {
	description = "Hiroglifs of Water",
	tiles = {"gods_hiro_water.png"},
	is_ground_content = true,
	groups = {magic=1},
	sounds = default.node_sound_stone_defaults(),
})
