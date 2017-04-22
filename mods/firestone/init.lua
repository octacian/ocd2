local makes_fire = false -- set to false if you want to light the fire yourself and extinguish it
local group
if makes_fire == true then
  group = {igniter=2, immortal, not_in_creative_inventory=1}
else
  group = {igniter=2, immortal, not_in_creative_inventory=1, dig_immediate=3}
end
minetest.register_alias("firestone", "firestone:firestone")
minetest.register_craft({
  output = '"firestone:firestone" 1',
  recipe = {
    {'default:stone', 'default:torch', 'default:stone'},
    {'default:stone', 'default:coal_lump', 'default:stone'},
    {'default:stone', 'default:stone', 'default:stone'},
  }
})
minetest.register_node("firestone:firestone", {
  description = "Fire node",
  tiles = {"default_mineral_coal.png", "default_stone.png", "default_stone.png"},
  groups = {igniter=2, cracky=3, stone=2},
  damage_per_second = 4,
  after_place_node = function(pos)
    local t = {x=pos.x, y=pos.y+1, z=pos.z}
    local n = minetest.env:get_node(t)
    if n.name == "air" and makes_fire == true then
      minetest.env:place_node(pointed_thing.above, {name="fire:basic_flame", param1 = 1})
    end
  end,
  after_dig_node = function(pos)
    local t = {x=pos.x, y=pos.y+1, z=pos.z}
    local n = minetest.env:get_node(t)
    if n.name == "fire:basic_flame" then
      minetest.env:remove_node(t)
    end
  end,
})
--aximx51v chimney code
minetest.register_abm(
  {nodenames = {"firestone:chimney"},
  neighbors = {"group:igniter"},
  interval = 5.0,
  chance = 1,
  action = function(pos, node, active_object_count, active_object_count_wider)
    p_bottom = {x=pos.x, y=pos.y-1, z=pos.z}
    n_bottom = minetest.env:get_node(p_bottom)
    local chimney_top = false
    local j = 1
    local node_param = minetest.registered_nodes[n_bottom.name]
    if node_param.groups.igniter then
      while chimney_top == false do
        upper_pos = {x=pos.x, y=pos.y+j, z=pos.z}
        upper_node = minetest.env:get_node(upper_pos)
        if  upper_node.name == "firestone:chimney" then
           j = j+1
        elseif upper_node.name == "air" then
          minetest.env:place_node(upper_pos,{name="firestone:smoke"})
          chimney_top = true
          elseif upper_node.name == "firestone:smoke" then
          local old = minetest.env:get_meta(upper_pos)
          old:set_int("age", 0)
          chimney_top = true
        elseif upper_node.name ~= "air" or upper_node.name ~= "firestone:chimney" or upper_node.name ~= "firestone:smoke" then
          chimney_top = true
        end
      end
    end
  end,
})
minetest.register_abm(
  {nodenames = {"firestone:smoke"},
  interval = 5.0,
  chance = 1,
  action = function(pos, node, active_object_count, active_object_count_wider)
    local old = minetest.env:get_meta(pos)
    if old:get_int("age") == 1 then
      minetest.env:remove_node(pos)
    else
      old:set_int("age", 1)
    end
  end
})
minetest.register_craft({
  output = '"firestone:chimney" 4',
  recipe = {
    {'', 'default:stone', ''},
    {'default:stone', '', 'default:stone'},
    {'', 'default:stone', ''},
  }
})
minetest.register_node("firestone:chimney", {
  description = "Chimney",
  drawtype = "nodebox",
  node_box = {type = "fixed",
    fixed = {
      {0.3125, -0.5, -0.5, 0.5, 0.5, 0.5},
      {-0.5, -0.5, 0.3125, 0.5, 0.5, 0.5},
      {-0.5, -0.5, -0.5, -0.3125, 0.5, 0.5},
      {-0.5, -0.5, -0.5, 0.5, 0.5, -0.3125},
    },
  },
  selection_box = {
    type = "regular",
  },
  tiles ={"default_stone.png"},
  paramtype = 'light',
  sunlight_propagates = true,
  walkable = true,
  groups = {cracky=2},
})
minetest.register_node("firestone:smoke", {
  description = "smoke",
  drawtype = "plantlike",
  tiles ={{
  name="firestone_smoke.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=4.0},
  }},
  sunlight_propagates = true,
  groups = {not_in_creative_inventory=1},
  paramtype = "light",
  walkable = false,
  pointable = false,
  diggable = false,
  buildable_to = true,
  light_source = 10,
  on_place_node = function(pos)
      local old = minetest.env:get_meta(pos)
      old:set_int("age", 0)
  end
})
-- original code from BlockMen
minetest.register_node(":soil:gravel", {
  description = "Gravel",
  tiles = {"soil_gravel.png"},
  is_ground_content = true,
  groups = {crumbly=2, falling_node=1},
  drop = {
    max_items = 1,
    items = {
      {
        items = {'firestone:flintstone'},
        rarity = 10,
      },
      {
        items = {'soil:gravel'},
      }
    }
  },
  sounds = default.node_sound_dirt_defaults({
    footstep = {name="soil_gravel_footstep", gain=0.45},
  }),
})
minetest.register_craftitem("firestone:flintstone", {
  description = "Flintstone",
  inventory_image = "flint_flintstone.png",
})
minetest.register_craft({
  output = 'firestone:lighter',
  recipe = {
    {'default:steel_ingot', ''},
    {'', 'firestone:flintstone'},
  }
})
local function set_fire(pointed_thing)
  local p = pointed_thing.above
  local n = minetest.env:get_node(p)
  if n.name ~= ""  and n.name == "air" then
    if minetest.get_node({x=p.x,y=p.y-1,z=p.z}).name == "firestone:firestone" then
      minetest.env:add_node(pointed_thing.above, {name="fire:basic_flame", param1 = 1})
    else
      minetest.env:place_node(pointed_thing.above, {name="fire:basic_flame"})
    end
  end
end
minetest.register_tool("firestone:lighter", {
  description = "Lighter",
  inventory_image = "flint_lighter.png",
  liquids_pointable = false,
  stack_max = 1,
  tool_capabilities = {
    full_punch_interval = 1.0,
    max_drop_level=0,
    groupcaps={
      flamable = {uses=65, maxlevel=1},
    }
  },
  --groups = {hot=3, igniter=1, not_in_creative_inventory=1},
  on_use = function(itemstack, user, pointed_thing)
    if pointed_thing.type == "node" then
      set_fire(pointed_thing)
      itemstack:add_wear(65535/65)
      return itemstack
    end
  end,

})
