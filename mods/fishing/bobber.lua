-----------------------------------------------------------------------------------------------
-- Fishing - Mossmanikin's version - Bobber 0.0.6
-- original by wulfsdad (http://forum.minetest.net/viewtopic.php?id=4375)
-- this version by Mossmanikin
-- License (code & textures): 	WTFPL
-- Contains code from: 		fishing (original), mobs, throwing
-- Supports:				animal_clownfish, animal_fish_blue_white, animal_rat, mobs
-----------------------------------------------------------------------------------------------
-- 0.0625 	(= 1 pixel on 16x16 texture)
-- 0.125 
-- 0.1875
-- 0.25
-- 0.3125
-- 0.375 
-- 0.4375
-- 0.5		(= 8 pixels on 16x16 texture)
-- 0.5625 	(= 9 pixels on 16x16 texture)
-- 0.625 
-- 0.6875
-- 0.75  
-- 0.8125
-- 0.875 
-- 0.9375
-- 1.0		(= 16 pixels on 16x16 texture)

minetest.register_node("fishing:bobber_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
--			{ left	, bottom , front  ,  right ,  top   ,  back  }
			{-0.0625, -0.6875, -0.0625,  0.0625, -0.5625,  0.0625},	
		}
	},
	tiles = {"fishing_bobber.png"},
	groups = {not_in_creative_inventory=1},
})

local FISHING_BOBBER_ENTITY={
	hp_max = 605,
	water_damage = 1,
	physical = true,
	timer = 0,
	env_damage_timer = 0,
	visual = "wielditem",
	visual_size = {x=0.5, y=0.5, z=0.5},
	textures = {"fishing:bobber_box"},
	--			   { left  , bottom , front  ,  right ,  top   ,  back  }
	collisionbox = {-0.125 , -0.5625, -0.125 ,  0.125 , -0.3125,  0.125 },
	view_range = 7,
--	DESTROY BOBBER WHEN PUNCHING IT
	on_punch = function (self, puncher, time_from_last_punch, tool_capabilities, dir)
		local player = puncher:get_player_name()
		if MESSAGES == true then
			--minetest.chat_send_all("Your fish escaped.")
			minetest.chat_send_player(player, "Your fish escaped.", false)
		end
		minetest.sound_play("fishing_bobber1", {
			pos = self.object:getpos(),
			gain = 0.5,
		})
		self.object:remove()
	end,
--	WHEN RIGHTCLICKING THE BOBBER THE FOLLOWING HAPPENS	(CLICK AT THE RIGHT TIME WHILE HOLDING A FISHING POLE)	
	on_rightclick = function (self, clicker)
		local item = clicker:get_wielded_item()
		local player = clicker:get_player_name()
		if item:get_name() == "fishing:pole" then
			local inv = clicker:get_inventory()
			local room_fish = inv:room_for_item("main", {name="fishing:fish_raw", count=1, wear=0, metadata=""})
			if self.object:get_hp() <= 300 then
			if math.random(1, 100) < FISH_CHANCE then
				local chance = math.random(1, 82)
				if chance <= 60 then
					if room_fish then
						inv:add_item("main", {name="fishing:fish_raw", count=1, wear=0, metadata=""})
						if MESSAGES == true then
							--minetest.chat_send_all("You caught a Fish.")
							minetest.chat_send_player(player, "You caught a Fish.", false)
						end
					end
				elseif chance <= 70 then
					if minetest.get_modpath("animal_clownfish") ~= nil then
						if inv:room_for_item("main", {name="animal_clownfish:clownfish", count=1, wear=0, metadata=""}) then
							inv:add_item("main", {name="animal_clownfish:clownfish", count=1, wear=0, metadata=""})
							if MESSAGES == true then
								--minetest.chat_send_all("You caught a Clownfish.")
								minetest.chat_send_player(player, "You caught a Clownfish.", false)
							end
						end
					else
						if room_fish then
							inv:add_item("main", {name="fishing:fish_raw", count=1, wear=0, metadata=""})
							if MESSAGES == true then
								--minetest.chat_send_all("You caught a Fish.")
								minetest.chat_send_player(player, "You caught a Fish.", false)
							end
						end
					end
				elseif chance <= 80 then
					if minetest.get_modpath("animal_fish_blue_white") ~= nil then
						if inv:room_for_item("main", {name="animal_fish_blue_white:fish_blue_white", count=1, wear=0, metadata=""}) then
							inv:add_item("main", {name="animal_fish_blue_white:fish_blue_white", count=1, wear=0, metadata=""})
							if MESSAGES == true then
								--minetest.chat_send_all("You caught a Blue white fish.")
								minetest.chat_send_player(player, "You caught a Blue white fish.", false)
							end
						end
					else
						if room_fish then
							inv:add_item("main", {name="fishing:fish_raw", count=1, wear=0, metadata=""})
							if MESSAGES == true then
								--minetest.chat_send_all("You caught a Fish.")
								minetest.chat_send_player(player, "You caught a Fish.", false)
							end
						end
					end	
				elseif chance == 81 then
					if inv:room_for_item("main", {name="default:stick", count=1, wear=0, metadata=""}) then
						inv:add_item("main", {name="default:stick", count=1, wear=0, metadata=""})
						if MESSAGES == true then
							--minetest.chat_send_all("You caught a Stick.")
							minetest.chat_send_player(player, "You caught a Stick.", false)
						end
					end
				elseif chance == 82 then
					if minetest.get_modpath("mobs") ~= nil then
						if inv:room_for_item("main", {name="mobs:rat", count=1, wear=0, metadata=""}) then
							inv:add_item("main", {name="mobs:rat", count=1, wear=0, metadata=""})
							if MESSAGES == true then
								--minetest.chat_send_all("You caught a Rat.")
								minetest.chat_send_player(player, "You caught a Rat.", false)
							end
						end
					elseif minetest.get_modpath("animal_rat") ~= nil then
						if inv:room_for_item("main", {name="animal_rat:rat", count=1, wear=0, metadata=""}) then
							inv:add_item("main", {name="animal_rat:rat", count=1, wear=0, metadata=""})
							if MESSAGES == true then
								--minetest.chat_send_all("You caught a Rat.")
								minetest.chat_send_player(player, "You caught a Rat.", false)
							end
						end
					else
						if inv:room_for_item("main", {name="rat", count=1, wear=0, metadata=""}) then
							inv:add_item("main", {name="rat", count=1, wear=0, metadata=""})
							if MESSAGES == true then
								--minetest.chat_send_all("You caught a Rat.")
								minetest.chat_send_player(player, "You caught a Rat.", false)
							end
						end
					end
				end
			
			else 
				if MESSAGES == true then
					--minetest.chat_send_all("Your fish escaped.")
					minetest.chat_send_player(player, "Your fish escaped.", false)
				end			
			end
			else 
			if MESSAGES == true then
				--minetest.chat_send_all("Your fish escaped.")
				minetest.chat_send_player(player, "Your fish escaped.", false)
			end
			end
		else 
			if MESSAGES == true then
				--minetest.chat_send_all("Your fish escaped.")
				minetest.chat_send_player(player, "Your fish escaped.", false)
			end			
		end
		minetest.sound_play("fishing_bobber1", {
			pos = self.object:getpos(),
			gain = 0.5,
		})
		self.object:remove()
	end,
-- AS SOON AS THE BOBBER IS PLACED IT WILL ACT LIKE
	on_step = function(self, dtime)
		local pos = self.object:getpos()
		if BOBBER_CHECK_RADIUS > 0 then
			local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, BOBBER_CHECK_RADIUS)
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name == "fishing:bobber_entity" then
						if obj:get_luaentity() ~= self then
							self.object:remove()
						end
					end
				end
			end
		end
		if math.random(1, 4) == 1 then
			self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/180*math.pi))
		end
		for _,player in pairs(minetest.get_connected_players()) do
			local s = self.object:getpos()
			local p = player:getpos()
			local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
			if dist > self.view_range then
				minetest.sound_play("fishing_bobber1", {
					pos = self.object:getpos(),
					gain = 0.5,
				})
				self.object:remove()
			end
		end	
		local do_env_damage = function(self)
			self.object:set_hp(self.object:get_hp()-self.water_damage)
			--local pos = self.object:getpos()
			if self.object:get_hp() == 600 then
				self.object:moveto({x=pos.x,y=pos.y-0.03125,z=pos.z})
			elseif self.object:get_hp() == 595 then
				self.object:moveto({x=pos.x,y=pos.y+0.03125,z=pos.z})
			elseif self.object:get_hp() == 590 then
				self.object:moveto({x=pos.x,y=pos.y+0.03125,z=pos.z})
			elseif self.object:get_hp() == 585 then
				self.object:moveto({x=pos.x,y=pos.y-0.03125,z=pos.z})
				self.object:set_hp(self.object:get_hp()-(math.random(1, 200)))
			elseif self.object:get_hp() == 300 then
				minetest.sound_play("fishing_bobber1", {
					pos = self.object:getpos(),
					gain = 0.5,
				})
				self.object:moveto({x=pos.x,y=pos.y-0.0625,z=pos.z})
			elseif self.object:get_hp() == 295 then
				self.object:moveto({x=pos.x,y=pos.y+0.0625,z=pos.z})
			elseif self.object:get_hp() == 290 then
				self.object:moveto({x=pos.x,y=pos.y+0.0625,z=pos.z})
			elseif self.object:get_hp() == 285 then
				self.object:moveto({x=pos.x,y=pos.y-0.0625,z=pos.z})
			elseif self.object:get_hp() == 160 then
				minetest.sound_play("fishing_bobber1", {
					pos = self.object:getpos(),
					gain = 0.5,
				})
				self.object:remove()
			end
		end
		do_env_damage(self)
	end,
}

minetest.register_entity("fishing:bobber_entity", FISHING_BOBBER_ENTITY)


