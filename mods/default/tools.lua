-- mods/default/tools.lua

-- The hand
minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
			snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=7.00,[2]=4.00,[3]=1.40}, uses=0, maxlevel=3}
		},
		damage_groups = {fleshy=1},
	}
})

-- Picks
minetest.register_tool("default:pick_wood", {
	description = "Wooden Pickaxe",
	inventory_image = "default_tool_woodpick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[3]=1.60}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:pick_wood_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:pick_stone", {
	description = "Stone Pickaxe",
	inventory_image = "default_tool_stonepick.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[2]=2.0, [3]=1.20}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
	  local wear = itemstack:get_wear()
	  local direction = minetest.dir_to_facedir(placer:get_look_dir())
	  local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
	  local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
	  minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:pick_stone_deco", param2=direction})
	  meta1:set_int("wear", wear)
	  meta2:set_int("wear", wear)
	  itemstack:take_item()
	  return itemstack
  end
	end,
})
minetest.register_tool("default:pick_steel", {
	description = "Steel Pickaxe",
	inventory_image = "default_tool_steelpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:pick_steel_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:pick_bronze", {
	description = "Bronze Pickaxe",
	inventory_image = "default_tool_bronzepick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:pick_bronze_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:pick_mese", {
	description = "Mese Pickaxe",
	inventory_image = "default_tool_mesepick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:pick_mese_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:pick_diamond", {
	description = "Diamond Pickaxe",
	inventory_image = "default_tool_diamondpick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:pick_diamond_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})

-- Shovels
minetest.register_tool("default:shovel_wood", {
	description = "Wooden Shovel",
	inventory_image = "default_tool_woodshovel.png",
	wield_image = "default_tool_woodshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			crumbly = {times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:shovel_wood_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:shovel_stone", {
	description = "Stone Shovel",
	inventory_image = "default_tool_stoneshovel.png",
	wield_image = "default_tool_stoneshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.4,
		max_drop_level=0,
		groupcaps={
			crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:shovel_stone_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:shovel_steel", {
	description = "Steel Shovel",
	inventory_image = "default_tool_steelshovel.png",
	wield_image = "default_tool_steelshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:shovel_steel_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:shovel_bronze", {
	description = "Bronze Shovel",
	inventory_image = "default_tool_bronzeshovel.png",
	wield_image = "default_tool_bronzeshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:shovel_bronze_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:shovel_mese", {
	description = "Mese Shovel",
	inventory_image = "default_tool_meseshovel.png",
	wield_image = "default_tool_meseshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:shovel_mese_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:shovel_diamond", {
	description = "Diamond Shovel",
	inventory_image = "default_tool_diamondshovel.png",
	wield_image = "default_tool_diamondshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:shovel_diamond_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
--
-- Axes
minetest.register_tool("default:axe_wood", {
	description = "Wooden Axe",
	inventory_image = "default_tool_woodaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			choppy = {times={[2]=3.00, [3]=2.00}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:axe_wood_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:axe_stone", {
	description = "Stone Axe",
	inventory_image = "default_tool_stoneaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=3.00, [2]=2.00, [3]=1.50}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:axe_stone_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:axe_steel", {
	description = "Steel Axe",
	inventory_image = "default_tool_steelaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:axe_steel_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:axe_bronze", {
	description = "Bronze Axe",
	inventory_image = "default_tool_bronzeaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:axe_bronze_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:axe_mese", {
	description = "Mese Axe",
	inventory_image = "default_tool_meseaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:axe_mese_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:axe_diamond", {
	description = "Diamond Axe",
	inventory_image = "default_tool_diamondaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:axe_diamond_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})

-- Swords
minetest.register_tool("default:sword_wood", {
	description = "Wooden Sword",
	inventory_image = "default_tool_woodsword.png",
        on_use = function(data)
          print(data)
        end,
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:sword_wood_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:sword_stone", {
	description = "Stone Sword",
	inventory_image = "default_tool_stonesword.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=4},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:sword_stone_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:sword_steel", {
	description = "Steel Sword",
	inventory_image = "default_tool_steelsword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:sword_steel_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:sword_bronze", {
	description = "Bronze Sword",
	inventory_image = "default_tool_bronzesword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:sword_bronze_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:sword_mese", {
	description = "Mese Sword",
	inventory_image = "default_tool_mesesword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:sword_mese_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
minetest.register_tool("default:sword_diamond", {
	description = "Diamond Sword",
	inventory_image = "default_tool_diamondsword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	},
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
    if ( minetest.get_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}).name == "air" ) then
		local wear = itemstack:get_wear()
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y  , z=pt.under.z})
		local meta2 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		minetest.set_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="default:sword_diamond_deco", param2=direction})
		meta1:set_int("wear", wear)
		meta2:set_int("wear", wear)
		itemstack:take_item()
		return itemstack
  end
	end,
})
local register_deco_block = function(tool_name, tool_tiles, tool_nodebox)
  minetest.register_node(tool_name.."_deco", {
	  drawtype = "nodebox",
	  paramtype = "light",
	  paramtype2 = "facedir",
	  tiles = tool_tiles,
	  groups = {
		  snappy=3,
		  flammable=2,
		  not_in_creative_inventory=1
	  },
	  node_box = {
		  type = "fixed",
		  fixed = tool_nodebox,
	  },
	  sounds = default.node_sound_wood_defaults(),
	  on_dig = function(pos, node, digger)
		  if digger:is_player() and digger:get_inventory() then
			  local meta = minetest.env:get_meta(pos)
			  local wear_out = meta:get_int("wear")
			  digger:get_inventory():add_item("main", {name=tool_name, count=1, wear=wear_out, metadata=""})
		  end
		  minetest.remove_node(pos)
	  end,
  })
end
local register_deco_block_materials = function(material, top)
  register_deco_block("default:pick_"..material, {top, "default_tool_"..material.."pick.png"}, {{-0.5/3, -1.5/3, -0.5/3, 0.5/3, 0.5/3, 0.5/3},{-0.5/3, 0.5/3, -1.5/3, 0.5/3, 1.5/3, 1.5/3}})
  register_deco_block("default:shovel_"..material, {top, "default_tool_"..material.."shovel.png"}, {{-0.5/3, -1.5/3, -0.5/3, 0.5/3, 1.5/3, 0.5/3}})
  register_deco_block("default:axe_"..material, {top, top, "default_tool_"..material.."axe.png^[transformFX", "default_tool_"..material.."axe.png", "default_tool_"..material.."axe.png^[combine:6x6:2,0=".."default_tool_"..material.."axe.png", "default_tool_"..material.."axe.png"}, {{-0.5/3, -1.5/3, -0.5/3, 0.5/3, 0.5/3, 0.5/3},{-0.5/3, 0.5/3, -0.5/3, 0.5/3, 1.5/3, 1.5/3},{-0.5/3, -0.5/3, 0.5/3, 0.5/3, 0.5/3, 1.5/3}})
  register_deco_block("default:sword_"..material, {top, "default_tool_"..material.."sword.png"}, {{-0.5/3, -1.5/3, -0.5/3, 0.5/3, 1.5/3, 0.5/3}})
end
register_deco_block_materials("stone", "default_cobble.png")
register_deco_block_materials("wood", "default_wood.png")
register_deco_block_materials("steel", "default_steel_block.png")
register_deco_block_materials("bronze", "default_bronze_block.png")
register_deco_block_materials("mese", "default_mese_block.png")
register_deco_block_materials("diamond", "default_diamond_block.png")
