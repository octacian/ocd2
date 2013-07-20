local weed = {}
local interval = 30
minetest.register_abm(
  {nodenames = {"default:grass_1"},
  neighbors = {"default:grass_1"},
  interval = interval,
  chance = 1,
  action = function(pos, node, active_object_count, active_object_count_wider)

    local level = (math.random(2))-1
    local placed = false
    local p = {x=pos.x-1,y=pos.y-level,z=pos.z}
    if (minetest.get_node(p).name=="default:dirt_with_grass") then
      local p = {x=pos.x-1,y=p.y+1,z=pos.z}
      if (minetest.get_node(p).name == "air") then
        minetest.add_node(p,node)
        placed = true
      end
    end

    local p = {x=pos.x+1,y=pos.y-level,z=pos.z}
    if (minetest.get_node(p).name=="default:dirt_with_grass") then
      local p = {x=pos.x+1, y=p.y+1,z=pos.z}
      if (minetest.get_node(p).name == "air") then
        minetest.add_node(p,node)
        placed = true
      end
    end
    
    local p = {x=pos.x,y=pos.y-level,z=pos.z-1}
    if (minetest.get_node(p).name=="default:dirt_with_grass") then
      local p = {x=pos.x,y=p.y+1,z=pos.z-1}
      if (minetest.get_node(p).name == "air") then
        minetest.add_node(p,node)
        placed = true
      end
    end
    
    local p = {x=pos.x,y=pos.y-level,z=pos.z+1}
    if (minetest.get_node(p).name=="default:dirt_with_grass") then
      local p = {x=pos.x,y=p.y+1,z=pos.z+1}
      if (minetest.get_node(p).name == "air") then
        minetest.add_node(p,node)
        placed = true
      end
    end
    
    if (math.random(4) == 1 or placed == true) then
      minetest.set_node(pos,{name="default:grass_"..math.random(4)+1})
    end
    
  end
})

minetest.register_abm({
  nodenames = {"default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"},
  neighbors = {"default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"},
  interval = interval*5,
  chance = 5,
  action = function(pos, node, active_object_count, active_object_count_wider)
    minetest.remove_node(pos)
  end
})

minetest.register_abm(
  {nodenames = {"default:dirt_with_grass"},
  neighbors = {"default:water_source"},
  interval = interval,
  chance = 200,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if (minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z}).name == "air") then
      minetest.add_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="default:grass_1"})
    end
  end
})

minetest.register_alias("weed:weed", "default:grass_1")
minetest.register_alias("weed:weed_dead", "default:grass_5")
