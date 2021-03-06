local mod = "tulips"
tulips_table = {}
img = ""
tulips_seed_diff = 420420
hue2 = "white"
minetest.register_node(mod..":plant", {--register wild plant
  tiles = {img},
  inventory_image = img,
  description = hue2.." tulip",
  drop = "",
  drawtype = "plantlike",
  paramtype = 'light',
  sunlight_propagates = true,
  walkable = false,
  visual_scale = 1.3,
  groups = {not_in_creative_inventory=1, snappy = 3,flammable=2, attached_node=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = { -0.25, -0.5, -0.25, 0.25, -3/16, 0.25 },
  },
})






for i = 1, 9 do
  local hue = dye.basecolors[i]
  local hue2 = dye.basecolors[i]
  local img = mod.."_"..hue..".png"
  --farming
  farming:add_plant(mod..":"..hue, {"tulips:"..hue.."_seeds",mod..":"..hue.."_sprout"}, 60, 2)
  tulips_table[i] = mod..":"..hue
  --node
  --tulip
  minetest.register_node(mod..":"..hue, {--register wild plant
    tiles = {img},
    inventory_image = img,
    description = hue.." tulip",
    drop = {
		  max_items = 3,
		  items = {
			  { items = {"dye:" .. hue} },
			  { items = {mod..":"..hue.."_seeds"} },
			  { items = {mod..":"..hue.."_seeds"}, rarity = 2},
			  { items = {mod..":"..hue.."_seeds"}, rarity = 5},
		  }
	  },
	  node_box = {
      type = "fixed",
      fixed = {
        {-0.5/5, -2.5/5, -0.5/5, 0.5/5, 0.5/5, 0.5/5},
        {-1.5/5, -0.5/5, -1.5/5, -0.5/5, 1.5/5, -0.5/5},
        {0.5/5, -0.5/5, -1.5/5, 1.5/5, 1.5/5, -0.5/5},
        {0.5/5, -0.5/5, 0.5/5, 1.5/5, 1.5/5, 1.5/5},
        {-1.5/5, -0.5/5, 0.5/5, -0.5/5, 1.5/5, 1.5/5},
      }
    },
    drawtype = "nodebox",
    paramtype = 'light',
    sunlight_propagates = true,
    walkable = false,
    visual_scale = 1,
    groups = { snappy = 3,flammable=2, attached_node=1, flower=1, flora=1, not_in_creative_inventory=1},
    sounds = default.node_sound_leaves_defaults(),
  })
  --sprout
  img = "tulips_sprout.png"
  minetest.register_node(mod..":"..hue.."_sprout", {--register wild plant
    tiles = {img},
    inventory_image = img,
    description = hue2.." tulip",
    drop = "",
    drawtype = "plantlike",
    paramtype = 'light',
    sunlight_propagates = true,
    walkable = false,
    visual_scale = 1,
    groups = { snappy = 3,flammable=2, attached_node=1, not_in_creative_inventory=1},
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
      type = "fixed",
      fixed = { -3/16, -8/16, -3/16, 3/16, 0, 3/16 },
    },
  })

  --seed
  img = mod.."_seeds.png"
  minetest.register_node(mod..":"..hue.."_seeds", {--register wild plant
    tiles = {img},
    inventory_image = img,
    description = hue.." tulip seeds",
    drawtype = "raillike",
    paramtype = 'light',
    sunlight_propagates = true,
    walkable = false,
    visual_scale = 1.3,
    groups = { snappy = 3,flammable=2, attached_node=1, not_in_creative_inventory=1},
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
      type = "fixed",
      fixed = {
        {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5}
      },
    },
  })
end

--spawning
plantslib:spawn_on_surfaces({
  spawn_delay = 2,
  spawn_plants = tulips_table,
  avoid_radius = 50,
  spawn_chance = 1500,
  spawn_surfaces = {"soil:dirt_with_grass"},
  avoid_nodes = {"group:flower"},
  seed_diff = tulips_seed_diff,
  light_min = 9
})

print("["..mod.."] Loaded!")
