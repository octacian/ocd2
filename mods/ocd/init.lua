minetest.register_node("ocd:stone_in_cobble", {
	description = "Stone in cobble",
	tiles = {"ocd_stone_in_cobble.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'default:cobble',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ocd:cobble_in_stone", {
	description = "Cobble in stone",
	tiles = {"ocd_cobble_in_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'default:cobble',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'ocd:cobble_in_stone 9',
	recipe = {
		{'default:stone', 'default:stone', 'default:stone'},
		{'default:stone', 'default:cobble', 'default:stone'},
		{'default:stone', 'default:stone', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'ocd:stone_in_cobble 9',
	recipe = {
		{'default:cobble', 'default:cobble', 'default:cobble'},
		{'default:cobble', 'default:stone', 'default:cobble'},
		{'default:cobble', 'default:cobble', 'default:cobble'},
	}
})
