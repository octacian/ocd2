local max_lenght = 200
local laser_groups = {igniter=2, not_in_creative_inventory=1}--igniter=2, 
local laser_damage = 8*2
local colours = {"red", "orange", "yellow", "green", "blue", "indigo", "violet", "white"}

local function invert_direction(dir)
	if dir == 3 then return 1 end
	if dir == 4 then return 2 end
	if dir == 1 then return 3 end
	if dir == 2 then return 4 end
	if dir == 6 then return 5 end
	if dir == 5 then return 6 end
	return 7
end

local function get_direction(name, pos)
	if minetest.env:get_node({x=pos.x-1, y=pos.y, z=pos.z}).name == name then return 1 end
	if minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z-1}).name == name then return 2 end
	if minetest.env:get_node({x=pos.x+1, y=pos.y, z=pos.z}).name == name then return 3 end
	if minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z+1}).name == name then return 4 end
	if minetest.env:get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == name then return 5 end
	if minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == name then return 6 end
	return 7
end

local function get_direction_laser(name, namev, pos)
	if minetest.env:get_node({x=pos.x-1, y=pos.y, z=pos.z}).name == name
	and minetest.env:get_node({x=pos.x-1, y=pos.y, z=pos.z}).param2 == 0 then
		return 1
	end
	if minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z-1}).name == name
	and minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z-1}).param2 == 1 then
		return 2
	end
	if minetest.env:get_node({x=pos.x+1, y=pos.y, z=pos.z}).name == name
	and minetest.env:get_node({x=pos.x+1, y=pos.y, z=pos.z}).param2 == 0 then
		return 3
	end
	if minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z+1}).name == name
	and minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z+1}).param2 == 1 then
		return 4
	end
	if minetest.env:get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == namev then return 5 end
	if minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == namev then return 6 end
	return 7
end


local function get_direction_pos(direction, i, pos)
	if direction == 1 then return {x=pos.x+i, y=pos.y, z=pos.z} end
	if direction == 2 then return {x=pos.x, y=pos.y, z=pos.z+i} end
	if direction == 3 then return {x=pos.x-i, y=pos.y, z=pos.z} end
	if direction == 4 then return {x=pos.x, y=pos.y, z=pos.z-i} end
	if direction == 5 then return {x=pos.x, y=pos.y+i, z=pos.z} end
	if direction == 6 then return {x=pos.x, y=pos.y-i, z=pos.z} end
end


local function get_direction_par(direction, name, name_v)
	if direction == 1 or direction == 3 then return {name=name, param2 = 0} end
	if direction == 2 or direction == 4 then return {name=name, param2 = 1} end
	return {name=name_v}
end

local function luftstrahl(pos, direction, colour)
	for i = 1, max_lenght, 1 do
		p = get_direction_pos(direction, i, pos)
		if minetest.env:get_node(p).name == "laser:detector_powered" then
			minetest.env:add_node(p, {name="laser:detector"})
			mesecon:receptor_off(p)
			return
		end
		if minetest.env:get_node(p).name == "laser:"..colour
		or minetest.env:get_node(p).name == "laser:"..colour.."_v" then
			minetest.env:remove_node(p)
		else
			return
		end
	end
end

local function laserstrahl(pos, name, name_v, direction, rnode)
	block = get_direction_par(direction, name, name_v)
	for i = 1, max_lenght, 1 do
		p = get_direction_pos(direction, i, pos)
		if minetest.env:get_node(p).name == "laser:detector" then
			minetest.env:add_node(p, {name="laser:detector_powered"})
			mesecon:receptor_on(p)
			return
		end
		if minetest.env:get_node(p).name == 'air' then
			minetest.env:add_node(p, block)
		else
			return
		end
	end
end

local function laserabm(pos, colour)
	local direction = get_direction('default:mese', pos)
	if direction ~= 7 then
		luftstrahl(pos, direction, colour)
	else
		local direction = get_direction("mesecons_extrawires:mese_powered", pos)
		if direction == 7 then
			return
		end
		local p = get_direction_pos(direction, 1, pos)
		laserstrahl(pos, "laser:"..colour, "laser:"..colour.."_v", direction)
	end
end

minetest.register_node("laser:detector", {
	description = "Laser Detector",
	tile_images = {"laserdetector.png"},
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults(),
	mesecons = {receptor = {
		state = mesecon.state.off
	}}
})

minetest.register_node("laser:detector_powered", {
	tile_images = {"laserdetector.png^[brighten"},
	groups = {cracky=1,level=2},
	sounds = default.node_sound_stone_defaults(),
	drop = "laser:detector",
	mesecons = {receptor = {
		state = mesecon.state.on
	}}
})

local function lasernode(name, desc, texture, nodebox)
minetest.register_node(name, {
	description = desc,
	tile_images = {texture},
	light_source = 15,
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	use_texture_alpha = true,
	damage_per_second = laser_damage,
	groups = laser_groups,
	drop = "",
	node_box = nodebox,
	sounds =  default.node_sound_leaves_defaults(),
	-- {-0.5, -0.1, -0.1, 0.5, 0.1, 0.1}, {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1},
})
end

local LASERBOX = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, 0.5, 0.5, 0},
			{-0.5, 0, -0.5, 0.5, 0, 0.5},
		}
	}

local LASERBOXV = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, 0.5, 0.5, 0},
			{0, -0.5, -0.5, 0, 0.5, 0.5},
		}
	}

local function after_dig_bob(pos, colour)
	local direction = invert_direction(get_direction_laser("laser:"..colour, "laser:"..colour.."_v", pos))
	while direction ~= 7 do
		luftstrahl(pos, direction, colour)
		direction = invert_direction(get_direction_laser("laser:"..colour, "laser:"..colour.."_v", pos))
	end
end

for _, colour in ipairs(colours) do

lasernode("laser:"..colour, colour.." laser", "laser_"..colour..".png^[transformR90", LASERBOX)
lasernode("laser:"..colour.."_v", "vertical "..colour.." laser", "laser_"..colour..".png", LASERBOXV)


--Bob Blocks

minetest.register_node(":bobblocks:"..colour.."block", {
	description = colour.." Block",
	drawtype = "glasslike",
	tile_images = {"bobblocks_"..colour.."block.png"},
	inventory_image = minetest.inventorycube("bobblocks_"..colour.."block.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	light_source = LIGHT_MAX-0,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	after_dig_node = function(pos)
		after_dig_bob(pos, colour)
	end,
	mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:"..colour.."block_off"
		},
	effector = {
		action_on = function (pos)
			laserabm(pos, colour)
		end,
		action_off = function (pos)
			laserabm(pos, colour)
		end,
	}}
})

minetest.register_node(":bobblocks:"..colour.."block_off", {
	description = colour.." Block",
	tile_images = {"bobblocks_"..colour.."block.png"},
	is_ground_content = true,
	alpha = WATER_ALPHA,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	drop = 'bobblocks:'..colour..'block',
	after_dig_node = function(pos)
		after_dig_bob(pos, colour)
	end,
	mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:"..colour.."block"
		},
	effector = {
		action_on = function (pos)
			laserabm(pos, colour)
		end,
		action_off = function (pos)
			laserabm(pos, colour)
		end,
	}}
})
end
--[[
function on_dignode(p, node)
	local direction = get_direction("mesecons_extrawires:mese_powered", pos)
	if direction == 7 then
		return
	end
	local p = get_direction_pos(direction, 1, pos)
	laserstrahl(pos, "laser:"..colour, "laser:"..colour.."_v", direction)
end
minetest.register_on_dignode(on_dignode)
]]
print("[laser] loaded")
