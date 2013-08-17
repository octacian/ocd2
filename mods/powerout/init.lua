powerout = {}

minetest.register_alias("default:torch", "powerout:light")

lamp_box = {
  type = "wallmounted",
  wall_top = {-0.2000,0.375,-0.2000,0.2000,0.5,0.2000},
  wall_bottom = {-0.2000,-0.5,-0.2000,0.2000,-0.375,0.2000},
  wall_side = {-0.375,-0.2000,-0.2000,-0.5,0.2000,0.2000},
}

minetest.register_node("powerout:light", {
  drawtype = "nodebox",
  description = "Electrical lamp",
  tiles = {"powerout_lamp.png"},
  inventory_image = "powerout_lamp_inventory.png",
  wield_image = "powerout_lamp_inventory.png",
  wield_light = 5,
  paramtype = "light",
  paramtype2 = "wallmounted",
  legacy_wallmounted = true,
  sunlight_propagates = true,
  walkable = false,
  node_box = lamp_box,
  groups = {attached_node=1, dig_immediate=3,not_in_creative_inventory=1},
  drop='powerout:light',
  sounds = default.node_sound_glass_defaults(),
  after_place_node = function(pos)
    local range = 20
    local meta = minetest.get_meta(pos)
    local minp = {x=pos.x-range, y=pos.y-range, z=pos.z-range}
    local maxp = {x=pos.x+range, y=pos.y+range, z=pos.z+range}
    local source_in_area = minetest.env:find_nodes_in_area(minp, maxp, "group:power_source")
    local node = minetest.get_node(pos)
    for i in ipairs(source_in_area) do
      local meta = minetest.get_meta(source_in_area[i])
      local power = meta:get_int("power")
      local max_power = meta:get_int("max_power")
      if power >= max_power then 
        --break
      else
        meta:set_int("power", power+1 )
        meta:set_string("infotext", (power+1).."/"..max_power )
        minetest.set_node(pos, {name="powerout:light_on", param2=node.param2})
        return nil
      end
    end
  end,
})

minetest.register_node("powerout:light_on", {
  drawtype = "nodebox",
  description = "Electrical lamp",
  tiles = {"powerout_lamp.png"},
  inventory_image = "powerout_lamp.png",
  wield_light = 5,
  paramtype = "light",
  paramtype2 = "wallmounted",
  light_source = 12,
  legacy_wallmounted = true,
  sunlight_propagates = true,
  walkable = false,
  node_box = lamp_box,
  groups = {attached_node=1, dig_immediate=3,not_in_creative_inventory=1},
  drop='powerout:light',
  sounds = default.node_sound_glass_defaults(),
  after_dig_node = function(pos, oldnode, oldmetadata, digger)
    local range = 20
    local minp = {x=pos.x-range, y=pos.y-range, z=pos.z-range}
    local maxp = {x=pos.x+range, y=pos.y+range, z=pos.z+range}
    local source_in_area = minetest.env:find_nodes_in_area(minp, maxp, "group:power_source")
    for i in ipairs(source_in_area) do
      local node = minetest.get_node(source_in_area[i])
      local meta = minetest.get_meta(source_in_area[i])
      local power =  meta:get_int("power")
      local max =  meta:get_int("max_power")
      if power > 0 then
        meta:set_int("power", power - 1 )
        meta:set_string("infotext", (power-1).."/"..max )
        return
      end
    end
  end,
})

minetest.register_node("powerout:solar_panel", {
  description = "Solar panel",
  drawtype = "nodebox",
  paramtype = "light",
  paramtype2 = "facedir",
  tiles = {"powerout_solar_panel.png", "default_steel_block.png", "powerout_solar_panel_side.png"},
  light_source = 3,
  groups = { oddly_breakable_by_hand=1, power_source=1 },
  node_box = {
    type = "fixed",
    fixed = {
      { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
    },
  },
  on_construct = function(pos)
    local light = minetest.get_node_light(pos, 0.5)
    print(light)
    local range = 20
    local max = math.floor(light/2)
    local meta = minetest.get_meta(pos)
    meta:set_int("max_power", max)
    meta:set_int("power", 0)
    local minp = {x=pos.x-range, y=pos.y-range, z=pos.z-range}
    local maxp = {x=pos.x+range, y=pos.y+range, z=pos.z+range}
    local lights_in_area = minetest.env:find_nodes_in_area(minp, maxp, "powerout:light")
    for i in ipairs(lights_in_area) do
      local node = minetest.get_node(lights_in_area[i])
      minetest.set_node(lights_in_area[i], {name="powerout:light_on", param2=node.param2})
      meta:set_int("power", i)
      meta:set_string("infotext", i.."/"..max )
      if max <= i then return end
    end
  end,
  on_destruct = function(pos)
    local range = 20
    local meta = minetest.get_meta(pos)
    local amount = meta:get_int("power")
    local minp = {x=pos.x-range, y=pos.y-range, z=pos.z-range}
    local maxp = {x=pos.x+range, y=pos.y+range, z=pos.z+range}
    local lights_in_area = minetest.env:find_nodes_in_area(minp, maxp, "powerout:light_on")
    for i in ipairs(lights_in_area) do
      if amount < i then return end
      local range = 20
      local meta = minetest.get_meta(pos)
      local minp = {x=lights_in_area[i].x-range, y=lights_in_area[i].y-range, z=lights_in_area[i].z-range}
      local maxp = {x=lights_in_area[i].x+range, y=lights_in_area[i].y+range, z=lights_in_area[i].z+range}
      local source_in_area = minetest.env:find_nodes_in_area(minp, maxp, "group:power_source")
      local node = minetest.get_node(lights_in_area[i])
      for ii in ipairs(source_in_area) do
        if vector.distance(pos, source_in_area[ii]) ~= 0  then
          local meta = minetest.get_meta(source_in_area[ii])
          local power = meta:get_int("power")
          local max_power = meta:get_int("max_power")
          if power < max_power then
            meta:set_int("power", power+1 )
            meta:set_string("infotext", (power+1).."/"..max_power )
            minetest.set_node(lights_in_area[i], {name="powerout:light_on", param2=node.param2})
            break
          else
            minetest.set_node(lights_in_area[i], {name="powerout:light", param2=node.param2})
          end
        else
          minetest.set_node(lights_in_area[i], {name="powerout:light", param2=node.param2})
        end
      end
    end
  end,
})

local max = 10
minetest.register_node("powerout:coal_plant", {
  description = "Coal plant",
  drawtype = "node",
  paramtype = "light",
  paramtype2 = "facedir",
  tiles = {"default_cobble.png", "default_cobble.png", "default_cobble.png", "default_cobble.png", "default_cobble.png", "powerout_coal_plant.png"},
  light_source = 3,
  groups = { oddly_breakable_by_hand=1, power_source=1 },
  on_construct = function(pos)
    local range = 20
    local meta = minetest.get_meta(pos)
    meta:set_int("max_power", max)
    meta:set_int("power", 0)
    local minp = {x=pos.x-range, y=pos.y-range, z=pos.z-range}
    local maxp = {x=pos.x+range, y=pos.y+range, z=pos.z+range}
    local lights_in_area = minetest.env:find_nodes_in_area(minp, maxp, "powerout:light")
    for i in ipairs(lights_in_area) do
      local node = minetest.get_node(lights_in_area[i])
      minetest.set_node(lights_in_area[i], {name="powerout:light_on", param2=node.param2})
      meta:set_int("power", i)
      meta:set_string("infotext", i.."/"..max )
      if max <= i then return end
    end
  end,
  on_destruct = function(pos)
    local range = 20
    local meta = minetest.get_meta(pos)
    local amount = meta:get_int("power")
    local minp = {x=pos.x-range, y=pos.y-range, z=pos.z-range}
    local maxp = {x=pos.x+range, y=pos.y+range, z=pos.z+range}
    local lights_in_area = minetest.env:find_nodes_in_area(minp, maxp, "powerout:light_on")
    for i in ipairs(lights_in_area) do
      if amount < i then return end
      local range = 20
      local meta = minetest.get_meta(pos)
      local minp = {x=lights_in_area[i].x-range, y=lights_in_area[i].y-range, z=lights_in_area[i].z-range}
      local maxp = {x=lights_in_area[i].x+range, y=lights_in_area[i].y+range, z=lights_in_area[i].z+range}
      local source_in_area = minetest.env:find_nodes_in_area(minp, maxp, "group:power_source")
      local node = minetest.get_node(lights_in_area[i])
      for ii in ipairs(source_in_area) do
        if vector.distance(pos, source_in_area[ii]) ~= 0  then
          local meta = minetest.get_meta(source_in_area[ii])
          local power = meta:get_int("power")
          local max_power = meta:get_int("max_power")
          if power < max_power then
            meta:set_int("power", power+1 )
            meta:set_string("infotext", (power+1).."/"..max_power )
            minetest.set_node(lights_in_area[i], {name="powerout:light_on", param2=node.param2})
            break
          else
            minetest.set_node(lights_in_area[i], {name="powerout:light", param2=node.param2})
          end
        else
          minetest.set_node(lights_in_area[i], {name="powerout:light", param2=node.param2})
        end
      end
    end
  end,
})

minetest.register_craft({
  output = 'powerout:solar_panel 4',
  recipe = {
    {'group:leafdecay', 'group:leafdecay', 'group:leafdecay'},
    {'default:steel_ingot','default:copper_ingot', 'default:steel_ingot'},
  }
})

minetest.register_craft({
  output = 'powerout:coal_plant 4',
  recipe = {
    {'default:cobble', 'default:cobble', 'default:cobble'},
    {'default:cobble', 'default:coalblock', 'default:cobble'},
    {'default:cobble', 'default:copper_ingot', 'default:cobble'},
  }
})

minetest.register_craft({
	output = 'powerout:light 8',
	recipe = {
		{'default:glass'},
		{'default:copper_ingot'},
	}
})
