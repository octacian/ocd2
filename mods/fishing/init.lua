-----------------------------------------------------------------------------------------------
local title		= "Fishing - Mossmanikin's version"
local version 	= "0.0.8"
local mname		= "fishing"
-----------------------------------------------------------------------------------------------
-- original by wulfsdad (http://forum.minetest.net/viewtopic.php?id=4375)
-- this version by Mossmanikin
-- License (code & textures): 	WTFPL
-- Contains code from: 		animal_clownfish, animal_fish_blue_white, fishing (original), stoneage
-- Looked at code from:		default, farming
-- Dependencies: 			default
-- Supports:				animal_clownfish, animal_fish_blue_white, animal_rat, mobs
-----------------------------------------------------------------------------------------------

-- todo: 	item wear 											done
--			automatic re-baiting option 						done
--			different types of fish/sushi, 						sort of
--			add sound											done
--			bobber												done
--			change rainworms filling inv & make 'em disappear 	sort of

-----------------------------------------------------------------------------------------------

dofile(minetest.get_modpath("fishing").."/fishes.lua")
dofile(minetest.get_modpath("fishing").."/crafting.lua")
dofile(minetest.get_modpath("fishing").."/settings.txt")
dofile(minetest.get_modpath("fishing").."/bobber.lua")

-----------------------------------------------------------------------------------------------
-- Worm
-----------------------------------------------------------------------------------------------
minetest.register_craftitem("fishing:bait_worm", {
	description = "Worm",
    groups = { fishing_bait=1 },
    inventory_image = "fishing_worm.png",
	on_use = minetest.item_eat(1),
})

-----------------------------------------------------------------------------------------------
-- Fishing Pole
-----------------------------------------------------------------------------------------------

local function rod_wear(itemstack, user, pointed_thing, uses)
	itemstack:add_wear(65535/(uses-1))
	return itemstack
end

minetest.register_tool("fishing:pole", {
	description = "Fishing Pole",
	groups = {},
	inventory_image = "fishing_pole.png",
	wield_image = "fishing_pole_wield.png",
	stack_max = 1,
	liquids_pointable = true,
	on_use = function (itemstack, user, pointed_thing)
		if pointed_thing and pointed_thing.under then
			local pt = pointed_thing
			local node = minetest.env:get_node(pt.under)
			if string.find(node.name, "default:water") then
				local player = user:get_player_name()
				local inv = user:get_inventory()
				if inv:get_stack("main", user:get_wield_index()+1):get_name() == "fishing:bait_worm" then
					inv:remove_item("main", "fishing:bait_worm")
					minetest.sound_play("fishing_bobber2", {
						pos = pt.under,
						gain = 0.5,
					})
					minetest.env:add_entity({interval = 1,x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, "fishing:bobber_entity")
					
					if WEAR_OUT == true then
						return rod_wear(itemstack, user, pointed_thing, 30)	
					else
						return {name="fishing:pole", count=1, wear=0, metadata=""}
					end
				end
			end
		end
		return nil
	end,
})

-----------------------------------------------------------------------------------------------
-- GETTING WORMS
-----------------------------------------------------------------------------------------------
-- get worms from digging in dirt:
if NEW_WORM_SOURCE == false then

minetest.register_node(":default:dirt", {
	description = "Dirt",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
 	after_dig_node = function (pos, oldnode, oldmetadata, digger)
 		if math.random(1, 100) < WORM_CHANCE then
			local tool_in_use = digger:get_wielded_item():get_name()
			if tool_in_use == "" or tool_in_use == "default:dirt" then
				local inv = digger:get_inventory()
 				if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
 					inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
 				end
 			end
 		end
 	end,
})

else
-- get worms from digging with hoes:

-- turns nodes with group soil=1 into soil
local function hoe_on_use(itemstack, user, pointed_thing, uses)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	
	local under = minetest.get_node(pt.under)
	local p = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
	local above = minetest.get_node(p)
	
	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end
	
	-- check if the node above the pointed thing is air
	if above.name ~= "air" then
		return
	end
	
	-- check if pointing at dirt
	if minetest.get_item_group(under.name, "soil") ~= 1 then
		return
	end
	
	-- turn the node into soil, play sound, get worm and wear out item
	minetest.set_node(pt.under, {name="farming:soil"})
	minetest.sound_play("default_dig_crumbly", {
		pos = pt.under,
		gain = 0.5,
	})
	local inv = user:get_inventory()
	if math.random(1, 100) < WORM_CHANCE then
		if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
			inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
		end
	end
	itemstack:add_wear(65535/(uses-1))
	return itemstack
end

-- didn't change the hoes, just here because hoe_on_use is local
minetest.register_tool(":farming:hoe_wood", {
	description = "Wooden Hoe",
	inventory_image = "farming_tool_woodhoe.png",
	on_use = function(itemstack, user, pointed_thing)
		return hoe_on_use(itemstack, user, pointed_thing, 30)
	end,
})
minetest.register_tool(":farming:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "farming_tool_stonehoe.png",
	on_use = function(itemstack, user, pointed_thing)
		return hoe_on_use(itemstack, user, pointed_thing, 90)
	end,
})
minetest.register_tool(":farming:hoe_steel", {
	description = "Steel Hoe",
	inventory_image = "farming_tool_steelhoe.png",
	on_use = function(itemstack, user, pointed_thing)
		return hoe_on_use(itemstack, user, pointed_thing, 200)
	end,
})
minetest.register_tool(":farming:hoe_bronze", {
	description = "Bronze Hoe",
	inventory_image = "farming_tool_bronzehoe.png",
	on_use = function(itemstack, user, pointed_thing)
		return hoe_on_use(itemstack, user, pointed_thing, 220)
	end,
})

end
-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------