minetest.register_node("demon:demon", {
  description = "Demon",
  drawtype = "node",
  paramtype = "light",
  paramtype2 = "facedir",
  tiles = {"demon_side.png","demon_side.png","demon_side.png","demon_side.png","demon_eyes_open.png", "demon_side.png"},
  damage_per_second = 10,
  light_source = 3,
  walkable = false,
  buildable_to = true,
  on_punch = function(pos, node, puncher)
    local health = puncher:get_hp()
    puncher:set_hp(health-2)
  end,
})

minetest.register_abm({ --remove bees
  nodenames = {"demon:demon"},
  interval = 2.5,
  chance = 1,
  action = function(pos, node, _, _)
    local meta = minetest.get_meta(pos)
    local range = 15
    local player = meta:get_string("player")
    if player == nil or player == "" then
      for _,player in pairs(minetest.get_connected_players()) do
        local s = pos
        local p = player:getpos()
        local dist = vector.distance(s,p)
        if dist < range then
          meta:set_string("player", player:get_player_name())
        end
      end
    end
    
    local player = meta:get_string("player")
    if player == nil or player == "" then return end
	  local name = player
	  local player = minetest.get_player_by_name(player)
	  local posp = player:getpos()
	  local newpos = {x = (pos.x + posp.x) / 2, y = (pos.y + posp.y) / 2 +1, z = (pos.z + posp.z) / 2}
	  local face = minetest.dir_to_facedir(vector.direction(pos, newpos), false)
	  
	  if minetest.get_node(newpos).name ~= "air" then return end
	  if vector.distance(newpos, posp) < 3 then
	    local health = player:get_hp()
      player:set_hp(health-2)
	    minetest.sound_play({name="demon_move"},{pos=newpos, max_hear_distance=32, gain=1.5})
	    minetest.remove_node(pos)
	    return
	  end
	  if minetest.get_node_light(newpos, nil) > 2 then 
	    if minetest.get_node_light(newpos, nil) > 8 then 
	      minetest.remove_node(pos)
	      minetest.sound_play({name="demon_remove"},{pos=newpos, max_hear_distance=32, gain=1})
	    end
	    if node.param2 ~= face then
	      minetest.set_node(pos, {name=node.name, param2 = face} )
	    end
	    return 
	  end
	  minetest.remove_node(pos)
	  minetest.set_node(newpos, {name="demon:demon", param2 = face})
	  local meta = minetest.get_meta(newpos)
	  meta:set_string("player", name)
	  minetest.sound_play({name="demon_move"},{pos=newpos, max_hear_distance=32, gain=1})
  end,
})

minetest.register_abm({
  nodenames = {"default:grass_5"},
  neighbors = {"default:tree"},
  interval = 60,
  chance = 4,
  action = function(pos, node, _, _)
    if minetest.get_node_light(pos, nil) < 3 then 
      minetest.set_node(pos, {name="demon:demon"})
    end
  end,
})
