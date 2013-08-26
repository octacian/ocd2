-----------------------------------------------------------------------------------------------
local title		= "Memorandum"
local version 	= "0.0.3"
local mname		= "memorandum"
-----------------------------------------------------------------------------------------------

minetest.register_craftitem(":default:paper", {
	description = "Paper",
	inventory_image = "default_paper.png",
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		minetest.add_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="memorandum:letter_empty", param2=direction})
		itemstack:take_item()
		return itemstack
	end,
})

minetest.register_node("memorandum:letter_empty", {
	drawtype = "nodebox",
	tiles = {"memorandum_letter_empty.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
		--	{ left	, bottom , front  ,  right ,  top   ,  back  }
			{ -1/2  , -1/2   , -1/2   , 1/2    , -7/16  ,  1/2  },
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -1/2  , -1/2   , -1/2   , 1/2    , -7/16  ,  1/2  },
		}
	},
	groups = {snappy=3,dig_immediate=2,attached_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "On this piece of paper is written: \"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		fields.text = fields.text or ""
		--print((sender:get_player_name() or "").." wrote \""..fields.text..
				--"\" to paper at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		local direction = minetest.env:get_node(pos).param2
		minetest.env:add_node(pos, {name="memorandum:letter_written", param2=direction})
		meta:set_string("infotext", 'On this piece of paper is written: "'..fields.text..'"')
	end,
})

minetest.register_craftitem("memorandum:letter", {
	description = "Letter",
	inventory_image = "default_paper.png^memorandum_letters.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		local player = user:get_player_name()
		local text = itemstack:get_metadata()
		minetest.chat_send_player(player, text, false)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		local direction = minetest.dir_to_facedir(placer:get_look_dir())
		local meta1 = minetest.env:get_meta({x=pt.under.x, y=pt.under.y+1, z=pt.under.z})
		local text = itemstack:get_metadata()
		minetest.add_node({x=pt.under.x, y=pt.under.y+1, z=pt.under.z}, {name="memorandum:letter_written", param2=direction})
		meta1:set_string("infotext", text)
		itemstack:take_item()
		return itemstack
	end,
})

minetest.register_node("memorandum:letter_written", {
	drawtype = "nodebox",
	tiles = {"memorandum_letter_empty.png^memorandum_letter_text.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
		--	{ left	, bottom , front  ,  right ,  top   ,  back  }
			{ -1/2  , -1/2   , -1/2   , 1/2    , -7/16  ,  1/2  },
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -1/2  , -1/2   , -1/2   , 1/2    , -7/16  ,  1/2  },
		}
	},
	groups = {snappy=3,dig_immediate=2,attached_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	on_dig = function(pos, node, digger)
		if digger:is_player() and digger:get_inventory() then
			local meta = minetest.env:get_meta(pos)
			local text = meta:get_string("infotext")
			digger:get_inventory():add_item("main", {name="memorandum:letter", count=1, wear=0, metadata=text})
		end
		minetest.remove_node(pos)
	end,
})

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------