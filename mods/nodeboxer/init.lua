local resolution = 6
local place_ori = nil
local place_one = nil
local place_two = nil
local node_num = 0
local node_box = {}
local node_box_string = {}
local node_current = 0

minetest.register_node("nodeboxer:spawn", {--register wild plant
  tiles = {"nodeboxer_model.png"},
  drawtype = "node",
  description = "Nodeboxer",
  groups = {not_in_creative_inventory=1, snappy = 3,flammable=2, attached_node=1},
  --[[
  on_rightclick = function(pos, node, clicker)
    place_one = nil
    place_two = nil
    place_ori = pos
    node_num = 0
    local player_name=clicker:get_player_name()
    minetest.chat_send_player(player_name,"[Nodeboxer] New project started")
    for x=1, resolution, 1 do
      for y=1, resolution, 1 do
        for z=1, resolution, 1 do
          local pos = {x=pos.x+x,y=pos.y+y,z=pos.z+z}
          minetest.set_node(pos, {name = "nodeboxer:grid"})
          local meta = minetest.get_meta(pos)
        end
      end
    end
  end,
  ]]--
  on_receive_fields = function(pos, formname, fields, clicker)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
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
            minetest.add_node({x=pos.x+x,y=pos.y+y,z=pos.z+z}, {name = "nodeboxer:wall"})
          end
        end
      end
    end
    
    local player_name=clicker:get_player_name()
    minetest.chat_send_player(player_name,"[Nodeboxer] New "..resolution.." project started")
    for x=1, resolution, 1 do
      for y=1, resolution, 1 do
        for z=1, resolution, 1 do
          local pos = {x=pos.x+x,y=pos.y+y,z=pos.z+z}
          minetest.set_node(pos, {name = "nodeboxer:grid"})
          local meta = minetest.get_meta(pos)
        end
      end
    end
		
	end,
  on_construct = function(pos, node)
    local meta = minetest.get_meta(pos)
    meta:set_string("infotext", "Left click to save | Right click for new project")
    meta:set_string("formspec", "field[text;;${text}]")
    for x=-resolution, resolution*2+1, 1 do
      for y=-1, resolution*2+1, 1 do
        for z=-resolution, resolution*2+1, 1 do
          if ( x == 0 and y == 0 and z == 0 ) then
            local a = 0
          else
            minetest.remove_node({x=pos.x+x,y=pos.y+y,z=pos.z+z})
          end
          if (x==-resolution or y==-1 or z==-resolution or x==resolution*2+1 or y==resolution*2+1 or z==resolution*2+1 ) then
            minetest.add_node({x=pos.x+x,y=pos.y+y,z=pos.z+z}, {name = "nodeboxer:wall"})
          end
        end
      end
    end
    
    place_ori = pos
    for x=1, resolution, 1 do
      for y=1, resolution, 1 do
        for z=1, resolution, 1 do
          local pos = {x=pos.x+x,y=pos.y+y,z=pos.z+z}
          minetest.set_node(pos, {name = "nodeboxer:grid"})
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
      minetest.chat_send_player(player_name,"[Nodeboxer] You have to draw before you can save.")
      return
    end
    local table_string = ""
    for i=1, node_num, 1 do
      minetest.chat_send_player(player_name,node_box_string[i])
      table_string = table_string..node_box_string[i]
    end
    minetest.chat_send_player(player_name,"[Nodeboxer] Saved project to mod folder")
    local file = minetest.get_modpath("nodeboxer").."/nodeboxes"
    local f = io.open(file, "r")
    local contents = f:read("*all")
    f = io.open(file, "w")
    f:write(contents.."{"..table_string.."},\n")
    f:close()
    file = minetest.get_modpath("nodeboxer").."/code"
    local f = io.open(file, "r")
    local code = f:read("*all")
    file = minetest.get_modpath("nodeboxer").."/nodeboxes.lua"
    f = io.open(file, "w")
    f:write("local node_boxes ={ "..contents.."{"..table_string.."},}\n"..code)
    f:close()
  end,
})

minetest.register_node("nodeboxer:grid", {--register wild plant
  drawtype = "glasslike_framed",
  paramtype = "light",
  groups = {dig_immediate=3,not_in_creative_inventory=1},
  light_source = 12,
  drop = "nodeboxer:paint",
  tiles = {"nodeboxer_wire.png"},
  sunlight_propagates = true,
  buildable_to = true,
  pointable = true,
  walkable = false,
	climbable = true,
})

minetest.register_node("nodeboxer:wall", {--register wild plant
  drawtype = "node",
  paramtype = "light",
  groups = {indestructable=1},
  light_source = 12,
  tiles = {"nodeboxer_wall.png"},
  --pointable = false,
})

minetest.register_node("nodeboxer:draw", {
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
        minetest.chat_send_player(player_name,"[Nodeboxer] Select a nodebox designer block")
        return 
      end
      place_one = pos
      minetest.chat_send_player(player_name,"[Nodeboxer] position 1 set")
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
      minetest.chat_send_player(player_name,"[Nodeboxer] position 2 set "..node_box_string[node_num])
      place_one = nil
      place_two = nil
      for x=min_x, max_x, 1 do
        for y=min_y, max_y, 1 do
          for z=min_z, max_z, 1 do
            --categorized[x.."-"..y.."-"..z] = nil
            minetest.add_node({x=x,y=y,z=z}, {name="nodeboxer:paint"})
          end
        end
      end
    end
  end,
})

minetest.register_node("nodeboxer:paint", {
  paramtype = "light",
  groups = {dig_immediate=3,not_in_creative_inventory=1},
  tiles = {"wool_blue.png"},
  pointable = true,
  walkable = false,
	climbable = true,
})
--update generation before generating
local file = minetest.get_modpath("nodeboxer").."/nodeboxes"
local f = io.open(file, "r")
local contents = f:read("*all")
file = minetest.get_modpath("nodeboxer").."/code"
f = io.open(file, "r")
local code = f:read("*all")
file = minetest.get_modpath("nodeboxer").."/nodeboxes.lua"
f = io.open(file, "w")
f:write("local node_boxes ={ "..contents.."}\n"..code)
f:close()
dofile(minetest.get_modpath("nodeboxer").."/nodeboxes.lua")
--crafts
minetest.register_craft({
  output = 'nodeboxer:draw',
  recipe = {
    {'nodeboxer:paint'},
  }
})

minetest.register_craft({
  output = 'nodeboxer:paint',
  recipe = {
    {'nodeboxer:draw'},
  }
})
