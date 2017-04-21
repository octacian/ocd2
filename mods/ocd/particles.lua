-- ocd/particles.lua

-- [local function] Calculate position
local function get_pos(pos)
  return {x = pos.x + math.random() - 0.5, y = pos.y + math.random() - 0.5,
      z = pos.z + math.random() - 0.5}
end

-- [particle abm] Fire
minetest.register_abm({
  nodenames = {"fire:basic_flame"},
  interval = 1,
  chance = 5,
  action = function(pos, node, active_object_count, active_object_count_wider)
    local p = get_pos(pos)
    -- Add particles
    minetest.add_particle(p, {x=0,y=1,z=0}, {x=0,y=math.random(10)/10,z=0},
        math.random(2,5), math.random(3), false, "ocd_particle_smoke.png")
    minetest.add_particle(p, {x=0,y=0,z=0}, {x=0,y=math.random(5)/10,z=0},
        math.random(1,3), math.random(2), false, "ocd_particle_flame.png")
  end
})

-- [particle abm] Furnace
minetest.register_abm({
  nodenames = {"default:furnace_active"},
  interval = 1,
  chance = 5,
  action = function(pos, node, active_object_count, active_object_count_wider)
    local p = get_pos(pos)
    -- Add particles
    minetest.add_particle(p, {x=0,y=1,z=0}, {x=0,y=math.random(10)/10,z=0},
        math.random(2,5), math.random(3), false, "ocd_particle_smoke.png")
  end
})

-- [particle abm] Mese(con)
minetest.register_abm({
  nodenames = {"default:stone_with_mese", "default:mese", "group:mesecon"},
  interval = 0.1,
  chance = 3,
  action = function(pos, node, active_object_count, active_object_count_wider)
    local p = get_pos(pos)
    local speed = 1 + math.random() * 2
    minetest.add_particle(p, {x=0,y=0,z=0},
        {x = (math.random()-0.5) / 5, y = -math.random(),
        z = (math.random()-0.5) / 5}, speed, math.random() * 2, true,
        "ocd_particle_mese.png")
  end
})

-- [particle abm] Lava
minetest.register_abm({
  nodenames = {"default:lava_source"},
  neighbors = {"air"},
  interval = 0.3,
  chance = 10,
  action = function(pos, node, active_object_count, active_object_count_wider)
    local p = get_pos(pos)
    -- Add particles
    minetest.add_particle(p, {x=0,y=1,z=0}, {x=0,y=math.random(10)/10,z=0},
        math.random(2,5), math.random(3), false, "ocd_particle_smoke.png")
    minetest.add_particle(p, {x=0,y=0,z=0}, {x=0,y=math.random(5)/10,z=0},
        math.random(1,3), math.random(2), false, "ocd_particle_flame.png")
  end
})
