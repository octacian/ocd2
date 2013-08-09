polymer = {}
polymer.registered_nodes = {}
polymer.node_amount = 0
polymer.extrude_amount = 0
local resolution = 12
local place_ori = nil
local place_one = nil
local place_two = nil
local node_num = 0
local node_box = {}
local node_box_string = {}
local node_current = 0

polymer.extruder_formspec = 
  "size[8,9]"..
  "list[current_name;models;0,0;8,4;]"..
  "button[2.5,4;1,1;polymer_prev;<]"..
  "list[current_name;input;3.5,4;1,1;]"..
  "button[4.5,4;1,1;polymer_next;>]"..
  "list[current_player;main;0,5;8,4;]"

polymer.setformspec = function(inv, page)
  local count = 0
  for i=(page-1)*8*4+1,(page)*8*4, 1 do
    count = count + 1
    if polymer.registered_nodes[i] == nil then 
      inv:set_stack("models", count, "")
    else
      inv:set_stack("models", count, polymer.registered_nodes[i].." "..polymer.extrude_amount)
      if count >= (8*4) or polymer.registered_nodes[i] == nil then return end
    end
  end
end,

minetest.register_node("polymer:extruder", {
  tiles = {"polymer_model.png"},
  drawtype = "node",
  description = "Polymer Extruder",
  groups = {not_in_creative_inventory=1, snappy = 3,flammable=2, attached_node=1},
  can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("input")
	end,
  on_construct = function(pos, node)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    inv:set_size("models", 8*4)
    inv:set_size("input", 1)
    inv:set_size("select", 1)
    inv:set_size("output", 1)
    meta:set_string("formspec", polymer.extruder_formspec)
    meta:set_int("page", 1)
    polymer.setformspec(inv, 1)
  end,
  on_receive_fields = function(pos, formname, fields, sender)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local page = meta:get_int("page")
    if fields.polymer_prev and page > 1 then
      polymer.setformspec(inv, page - 1)
      meta:set_int("page", page - 1)
    end
    if fields.polymer_next and  polymer.node_amount-(page)*4*8 > 0 then
      polymer.setformspec(inv, page + 1)
      meta:set_int("page", page + 1)
    end
  end,
  allow_metadata_inventory_put = function(pos, listname, index, stack, player)
    if listname == "models" then return 0 end
    if listname == "input" then
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local node_stack = inv:get_stack("input", 1)
      print(node_stack:get_count())
      if node_stack:get_count() ~= 0 and node_stack:get_name() ~= stack:get_name() then return 0 end
      return stack:get_count()
    end
    return 0
  end,
  on_metadata_inventory_put = function(pos, listname, index, stack, player)
    if listname == "input" then
      --print(minetest.get_item_group(minetest.get_node(pos).name, "polymer"))
      --minetest.get_node_group(self.node.name, "polymer")
      print(minetest.get_node_group(minetest.get_node(pos).name, "polymer"))
      if minetest.get_node_group(stack:get_name(), "polymer") == 0 then
        local player_name=player:get_player_name()
        minetest.chat_send_player(player_name,"[polymer] only works with plastic nodes")
        return
      else
      end
      --if minetest.get_node_group(, "polymer") ~= 0 then return end
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      polymer.extrude_amount = inv:get_stack("input", 1):get_count()
      local page = meta:get_int("page")
      polymer.setformspec(inv, page)
    end
  end,
  on_metadata_inventory_take = function(pos, listname, index, stack, player)
    if listname == "input" then
      local meta = minetest.get_meta(pos)
      local page = meta:get_int("page")
      local inv = meta:get_inventory()
      polymer.extrude_amount = inv:get_stack("input", 1):get_count()
      polymer.setformspec(inv, page)
    end
    if listname == "models" then
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local take = stack:get_count()
      print(take)
      local input_stack = inv:get_stack("input", 1)
      polymer.extrude_amount = (input_stack:get_count() - take)
      local page = meta:get_int("page")
      local name = input_stack:get_name()
      inv:set_stack("input", 1 ,name.." "..polymer.extrude_amount)
      print(stack:get_name())
      polymer.setformspec(inv, page)
    end
	end,
})

minetest.register_node("polymer:spawn", {
  tiles = {"polymer_model.png"},
  drawtype = "node",
  description = "Polymer Designer",
  groups = {not_in_creative_inventory=1, snappy = 3,flammable=2, attached_node=1},
  on_receive_fields = function(pos, formname, fields, clicker)
    

    if tonumber(fields.text) == nil then
      local player_name=clicker:get_player_name()
      minetest.chat_send_player(player_name,"[polymer] Only a number is allowed")
      return
    end
    
    local meta = minetest.get_meta(pos)
    resolution = fields.text or ""
    meta:set_string("infotext", '"'..fields.text..'"')
    place_one = nil
    place_two = nil
    place_ori = pos
    node_num = 0
    for x=-resolution, resolution*2+1, 1 do
      for y=-1, resolution*2+1, 1 do
        for z=-resolution, resolution*2+1, 1 do
          if ( x == 0 and y == 0 and z == 0 ) then
            local a = 0
          else
            minetest.remove_node({x=pos.x+x,y=pos.y+y,z=pos.z+z})
          end
          if (x==-resolution or y==-1 or z==-resolution or x==resolution*2+1 or y==resolution*2+1 or z==resolution*2+1 ) then
            minetest.add_node({x=pos.x+x,y=pos.y+y,z=pos.z+z}, {name = "polymer:wall"})
          end
        end
      end
    end
    
    local player_name=clicker:get_player_name()
    minetest.chat_send_player(player_name,"[polymer] New "..resolution.." project started")
    for x=1, resolution, 1 do
      for y=1, resolution, 1 do
        for z=1, resolution, 1 do
          local pos = {x=pos.x+x,y=pos.y+y,z=pos.z+z}
          minetest.set_node(pos, {name = "polymer:grid"})
          local meta = minetest.get_meta(pos)
        end
      end
    end
  end,
  on_construct = function(pos, node)
    local meta = minetest.get_meta(pos)
    meta:set_string("infotext", "Left click to save | Right click for new project")
    meta:set_string("formspec", "field[text;;12]")
    for x=-resolution, resolution*2+1, 1 do
      for y=-1, resolution*2+1, 1 do
        for z=-resolution, resolution*2+1, 1 do
          if ( x == 0 and y == 0 and z == 0 ) then
            local a = 0
          else
            minetest.remove_node({x=pos.x+x,y=pos.y+y,z=pos.z+z})
          end
          if (x==-resolution or y==-1 or z==-resolution or x==resolution*2+1 or y==resolution*2+1 or z==resolution*2+1 ) then
            minetest.add_node({x=pos.x+x,y=pos.y+y,z=pos.z+z}, {name = "polymer:wall"})
          end
        end
      end
    end
    
    place_ori = pos
    for x=1, resolution, 1 do
      for y=1, resolution, 1 do
        for z=1, resolution, 1 do
          local pos = {x=pos.x+x,y=pos.y+y,z=pos.z+z}
          minetest.set_node(pos, {name = "polymer:grid"})
          local meta = minetest.get_meta(pos)
        end
      end
    end
  end,
  on_destruct = function(pos, node, digger)
    for x=1, resolution, 1 do
      for y=1, resolution, 1 do
        for z=1, resolution, 1 do
          minetest.remove_node({x=pos.x+x,y=pos.y+y,z=pos.z+z})
        end
      end
    end
    local place_one = nil
    local place_two = nil
  end,
  on_punch = function(pos, node, puncher)
    local player_name=puncher:get_player_name()
    if node_num == 0 then
      minetest.chat_send_player(player_name,"[polymer] You have to draw before you can save.")
      return
    end
    local table_string = ""
    for i=1, node_num, 1 do
      minetest.chat_send_player(player_name,node_box_string[i])
      table_string = table_string..node_box_string[i]
    end
    minetest.chat_send_player(player_name,"[polymer] Saved project to mod folder")
    local file = minetest.get_modpath("polymer").."/nodeboxes"
    local f = io.open(file, "r")
    local contents = f:read("*all")
    f = io.open(file, "w")
    f:write(contents.."{"..table_string.."},\n")
    f:close()
    file = minetest.get_modpath("polymer").."/code"
    local f = io.open(file, "r")
    local code = f:read("*all")
    file = minetest.get_modpath("polymer").."/nodeboxes.lua"
    f = io.open(file, "w")
    f:write("local node_boxes ={ "..contents.."{"..table_string.."},}\n"..code)
    f:close()
  end,
})

minetest.register_node("polymer:grid", {--register wild plant
  drawtype = "glasslike_framed",
  paramtype = "light",
  groups = {dig_immediate=3,not_in_creative_inventory=1},
  light_source = 12,
  drop = "polymer:paint",
  tiles = {"polymer_wire.png"},
  sunlight_propagates = true,
  buildable_to = true,
  pointable = true,
  walkable = false,
	climbable = true,
})

minetest.register_node("polymer:wall", {--register wild plant
  drawtype = "node",
  paramtype = "light",
  groups = {indestructable=1},
  light_source = 12,
  tiles = {"polymer_wall.png"},
  --pointable = false,
})

minetest.register_node("polymer:draw", {
  paramtype = "light",
  groups = {dig_immediate=3,not_in_creative_inventory=1},
  tiles = {"wool_red.png"},
  pointable = true,
  climbable = true,
  buildable_to = true,
  walkable = false,
  after_dig_node = function(pos)
    place_one = nil
    place_two = nil
  end,
  after_place_node = function(pos, player)
    local player_name=player:get_player_name()
    if place_one == nil then
      if place_ori == nil then 
        minetest.chat_send_player(player_name,"[polymer] Select a nodebox designer block")
        return 
      end
      place_one = pos
      minetest.chat_send_player(player_name,"[polymer] position 1 set")
    elseif place_two == nil then
      place_two = pos
      local min_x = math.min(place_one.x, place_two.x)
      local min_y = math.min(place_one.y, place_two.y)
      local min_z = math.min(place_one.z, place_two.z)
      local max_x = math.max(place_one.x, place_two.x)
      local max_y = math.max(place_one.y, place_two.y)
      local max_z = math.max(place_one.z, place_two.z)
      node_num = node_num + 1
      node_box[node_num] = {{x=min_x, y=min_y, z=min_z},{x=max_x, y=max_y, z=max_z}}
      node_box_string[node_num] = "{"..(min_x-place_ori.x-(resolution/2+1)).."/"..resolution..", "..(min_y-place_ori.y-(resolution/2+1)).."/"..resolution..", "..(min_z-place_ori.z-(resolution/2+1)).."/"..resolution..", "..(max_x-place_ori.x-(resolution/2)).."/"..resolution..", "..(max_y-place_ori.y-(resolution/2)).."/"..resolution..", "..(max_z-place_ori.z-(resolution/2)).."/"..resolution.."},"
      minetest.chat_send_player(player_name,"[polymer] position 2 set "..node_box_string[node_num])
      place_one = nil
      place_two = nil
      for x=min_x, max_x, 1 do
        for y=min_y, max_y, 1 do
          for z=min_z, max_z, 1 do
            --categorized[x.."-"..y.."-"..z] = nil
            minetest.add_node({x=x,y=y,z=z}, {name="polymer:paint"})
          end
        end
      end
    end
  end,
})

minetest.register_node("polymer:paint", {
  paramtype = "light",
  groups = {dig_immediate=3,not_in_creative_inventory=1},
  tiles = {"wool_blue.png"},
  pointable = true,
  walkable = false,
	climbable = true,
})

local file = minetest.get_modpath("polymer").."/nodeboxes"
local f = io.open(file, "r")
local contents = f:read("*all")
file = minetest.get_modpath("polymer").."/code"
f = io.open(file, "r")
local code = f:read("*all")
file = minetest.get_modpath("polymer").."/nodeboxes.lua"
f = io.open(file, "w")
f:write("local node_boxes ={ "..contents.."}\n"..code)
f:close()
dofile(minetest.get_modpath("polymer").."/nodeboxes.lua")
--crafts
minetest.register_craft({
  output = 'polymer:draw',
  recipe = {
    {'polymer:paint'},
  }
})

minetest.register_craft({
  output = 'polymer:paint',
  recipe = {
    {'polymer:draw'},
  }
})

minetest.register_craftitem("polymer:polymers", {
	description = "Polymer",
	inventory_image = "farming_cake_mix_pumpkin.png",
})

minetest.register_craft({
	type = "cooking",
	output = "polymer:polymers",
	recipe = "farming:wheat_harvested",
	cooktime = 10
})
