--------------------------------------------------------------------------------------------------------
--Ambience Configuration for serverlite version 121712

local max_frequency_all = 1000 --the larger you make this number the lest frequent ALL sounds will happen recommended values between 100-2000.
local volume = 0.3


--for frequencies below use a number between 0 and max_frequency_all
--for volumes below, use a number between 0.0 and 1, the larger the number the louder the sounds
local night_frequency = 20  --owls, wolves 
local night_volume = volume
local day_frequency = 80  --crow, bluejay, cardinal
local day_volume = volume
local cave_frequency = 80  --bats
local cave_volume = volume
local beach_frequency = 20  --seagulls
local beach_volume = volume
local desert_frequency = 20  --coyote
local desert_volume = volume

local water_surface_volume = volume   -- sloshing water
local lava_volume = volume --lava
local flowing_water_volume = volume--waterfall
local splashing_water_volume = volume

--End of Config
----------------------------------------------------------------------------------------------------
local ambiences
local counter=0--*****************
local SOUNDVOLUME = 1
local MUSICVOLUME = 1
local sound_vol = 1
local last_x_pos = 0
local last_y_pos = 0
local last_z_pos = 0
local node_under_feet
local node_at_upper_body
local node_at_lower_body
local node_3_under_feet
local played_on_start = false

local night = {
	handler = {},
	frequency = night_frequency,
	{name="hornedowl", length=2, gain=night_volume},
	{name="wolves", length=4,  gain=night_volume},
	{name="cricket", length=6, gain=night_volume},
	{name="deer1", length=7, gain=night_volume},
	{name="deer2", length=7, gain=night_volume},
	{name="frog", length=1, gain=night_volume},
	{name="raccoon", length=1, gain=night_volume},

}
local day = {
	handler = {},
	frequency = day_frequency,
	{name="cardinal", length=3, gain=day_volume},
	{name="craw", length=3, gain=day_volume},
	{name="bluejay", length=6, gain=day_volume},
	{name="canadianloon1", length=10, gain=day_volume},
	{name="canadianloon2", length=14, gain=day_volume},
	{name="robin", length=4, gain=day_volume},
	{name="bird1", length=11, gain=day_volume},
	{name="bird2", length=6, gain=day_volume},
	{name="crestedlark", length=6, gain=day_volume},
	{name="peacock", length=2, gain=day_volume},
}
local cave = {
	handler = {},
	frequency = cave_frequency,
	{name="drippingwater", length=1.5, gain=cave_volume},
}
local beach = {
	handler = {},
	frequency = beach_frequency,
	{name="seagull", length=4.5, gain=beach_volume},
	{name="beach", length=13, gain=beach_volume},
	{name="gull", length=1, gain=beach_volume}
}
local desert = {
	handler = {},
	frequency = desert_frequency,
	{name="coyote", length=2.5, gain=desert_volume},
	{name="desertwind", length=8, gain=desert_volume},
	{name="alpaca", length=8, gain=desert_volume}
}
local water_surface = {
	handler = {},
	frequency = 1000,
	{name="goose", length=1, gain=water_surface_volume},
	{name="lake1", length=7, gain=water_surface_volume},
	{name="lake2", length=6, gain=water_surface_volume}
}
local flowing_water = {
	handler = {},
	frequency = 1000,
	{name="waterfall", length=6, gain=flowing_water_volume}
}


local lava = {
	handler = {},
	frequency = 1000,
	{name="lava", length=7, gain=lava_volume}
}

local is_daytime = function()
	return (minetest.env:get_timeofday() > 0.2 and  minetest.env:get_timeofday() < 0.8)
end

local nodes_in_range = function(pos, search_distance, node_name)
	minp = {x=pos.x-search_distance,y=pos.y-search_distance, z=pos.z-search_distance}
	maxp = {x=pos.x+search_distance,y=pos.y+search_distance, z=pos.z+search_distance}
	nodes = minetest.env:find_nodes_in_area(minp, maxp, node_name)
	--minetest.chat_send_all("Found (" .. node_name .. ": " .. #nodes .. ")")
	return #nodes
end

local nodes_in_coords = function(minp, maxp, node_name)
	nodes = minetest.env:find_nodes_in_area(minp, maxp, node_name)
	--minetest.chat_send_all("Found (" .. node_name .. ": " .. #nodes .. ")")
	return #nodes
end

local atleast_nodes_in_grid = function(pos, search_distance, height, node_name, threshold)
	counter = counter +1
--	minetest.chat_send_all("counter: (" .. counter .. ")")
	minp = {x=pos.x-search_distance,y=height, z=pos.z+20}
	maxp = {x=pos.x+search_distance,y=height, z=pos.z+20}
	nodes = minetest.env:find_nodes_in_area(minp, maxp, node_name)
--	minetest.chat_send_all("z+Found (" .. node_name .. ": " .. #nodes .. ")")
	if #nodes >= threshold then
		return true
	end
	totalnodes = #nodes
	minp = {x=pos.x-search_distance,y=height, z=pos.z-20}
	maxp = {x=pos.x+search_distance,y=height, z=pos.z-20}
	nodes = minetest.env:find_nodes_in_area(minp, maxp, node_name)
--	minetest.chat_send_all("z-Found (" .. node_name .. ": " .. #nodes .. ")")
	if #nodes >= threshold then
		return true
	end
	totalnodes = totalnodes + #nodes
	maxp = {x=pos.x+20,y=height, z=pos.z+search_distance}
	minp = {x=pos.x+20,y=height, z=pos.z-search_distance}
	nodes = minetest.env:find_nodes_in_area(minp, maxp, node_name)	
--	minetest.chat_send_all("x+Found (" .. node_name .. ": " .. #nodes .. ")")
	if #nodes >= threshold then
		return true
	end
	totalnodes = totalnodes + #nodes
	maxp = {x=pos.x-20,y=height, z=pos.z+search_distance}
	minp = {x=pos.x-20,y=height, z=pos.z-search_distance}
	nodes = minetest.env:find_nodes_in_area(minp, maxp, node_name)	
--	minetest.chat_send_all("x+Found (" .. node_name .. ": " .. #nodes .. ")")	
	if #nodes >= threshold then
		return true
	end
	totalnodes = totalnodes + #nodes
--	minetest.chat_send_all("Found total(" .. totalnodes .. ")")
	if totalnodes >= threshold*2 then
		return true
	end	
	return false
end

local get_immediate_nodes = function(pos)
	pos.y = pos.y-1
	node_under_feet = minetest.env:get_node(pos).name
	pos.y = pos.y-3
	node_3_under_feet = minetest.env:get_node(pos).name
	pos.y = pos.y+3
	pos.y = pos.y+2.2
	node_at_upper_body = minetest.env:get_node(pos).name
	pos.y = pos.y-1.19   
	node_at_lower_body = minetest.env:get_node(pos).name
	pos.y = pos.y+0.99  
	--minetest.chat_send_all("node_under_feet(" .. nodename .. ")")
end 

local get_ambience = function(player)
	local player_is_climbing = false
	local player_is_descending = false
	local player_is_moving_horiz = false
	local standing_in_water = false
	local pos = player:getpos()
	get_immediate_nodes(pos)

	if last_x_pos ~=pos.x or last_z_pos ~=pos.z then 
		player_is_moving_horiz = true 
	end
	if pos.y > last_y_pos+.5   then 
		player_is_climbing = true 
	end
	if pos.y < last_y_pos-.5  then 
		player_is_descending = true 
	end
	
	last_x_pos =pos.x
	last_z_pos =pos.z	
	last_y_pos =pos.y
	
	local air_or_ignore = {air=true,ignore=true}
	minp = {x=pos.x-3,y=pos.y-4, z=pos.z-3}
	maxp = {x=pos.x+3,y=pos.y-1, z=pos.z+3}
	local air_under_player = nodes_in_coords(minp, maxp, "air")
	local ignore_under_player = nodes_in_coords(minp, maxp, "ignore")
	air_plus_ignore_under = air_under_player + ignore_under_player

	if nodes_in_range(pos, 7, "default:lava_flowing")>5 or nodes_in_range(pos, 7, "default:lava_source")>5 then
		return {lava=lava}		
	end
	if nodes_in_range(pos, 6, "default:water_flowing")>45 then
		return {flowing_water=flowing_water}
	end	
--if we are near sea level and there is lots of water around the area
	if pos.y < 7 and pos.y >0 and atleast_nodes_in_grid(pos, 60, 1, "default:water_source", 51 ) then
		return {beach=beach}
	end
	if standing_in_water then
		return {water_surface=water_surface}
	end
	desert_in_range = (nodes_in_range(pos, 6, "default:desert_sand")+nodes_in_range(pos, 6, "default:desert_stone"))
	--minetest.chat_send_all("desertcount: " .. desert_in_range .. ",".. pos.y )
	if  desert_in_range >250 then
		return {desert=desert}
	end	
	if player:getpos().y < 0 then
		return {cave=cave}
	end
	if is_daytime() then
		return {day=day}
	else
		return {night=night}
	end
end

-- start playing the sound, set the handler and delete the handler after sound is played
local play_sound = function(player, list, number)
	local player_name = player:get_player_name()
	if list.handler[player_name] == nil then
		local gain = 1.0
		if list[number].gain ~= nil then
			gain = list[number].gain*SOUNDVOLUME 
		end
		local handler = minetest.sound_play(list[number].name, {to_player=player_name, gain=gain})
		if handler ~= nil then
			list.handler[player_name] = handler
			minetest.after(list[number].length, function(args)
				local list = args[1]
				local player_name = args[2]
				if list.handler[player_name] ~= nil then
					minetest.sound_stop(list.handler[player_name])
					list.handler[player_name] = nil
				end
			end, {list, player_name})
		end
	end
end

-- stops all sounds that are not in still_playing
local stop_sound = function(still_playing, player)
	local player_name = player:get_player_name()
	if still_playing.cave == nil then
		local list = cave
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name(),gain=SOUNDVOLUME})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end

	if still_playing.beach == nil then
		local list = beach
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name(),gain=SOUNDVOLUME})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.desert == nil then
		local list = desert
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name(),gain=SOUNDVOLUME})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.night == nil then
		local list = night
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name(),gain=SOUNDVOLUME})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.day == nil then
		local list = day
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name(),gain=SOUNDVOLUME})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.flowing_water == nil then
		local list = flowing_water
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name(),gain=SOUNDVOLUME})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.lava == nil then
		local list = lava
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name(),gain=SOUNDVOLUME})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end	
	if still_playing.water_surface == nil then
		local list = water_surface
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then				
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name(),gain=SOUNDVOLUME})
				played_on_start = false
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
end
local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer+dtime
	if timer < 1 then
		return
	end
	timer = 0
	for _,player in ipairs(minetest.get_connected_players()) do
		ambiences = get_ambience(player)
		stop_sound(ambiences, player)
		for _,ambience in pairs(ambiences) do
			if math.random(1, 1000) <= ambience.frequency then			
				if ambience.on_start ~= nil and played_on_start == false then
					played_on_start = true
					minetest.sound_play(ambience.on_start, {to_player=player:get_player_name(),gain=SOUNDVOLUME})					
				end
				play_sound(player, ambience, math.random(1, #ambience))
			end
		end
	end
end)

minetest.register_chatcommand("svol", {
	params = "<svol>",
	description = "set volume of sounds, default 1 normal volume.",
	privs = {server=true},
	func = function(name, param)
		SOUNDVOLUME = param
	--	local player = minetest.env:get_player_by_name(name)
	--	ambiences = get_ambience(player)
	--	stop_sound({}, player)
		minetest.chat_send_player(name, "Sound volume set.")
	end,		})

