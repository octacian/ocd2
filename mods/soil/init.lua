-- soil/init.lua

soil = {}

---
--- API
---

-- [function] Register soil
function soil.register(name, def)
  if not def.groups then def.groups = {} end
  def.groups.crumbly = def.groups.crumbly or 3
  def.groups.soil = def.groups.soil or 1
  def.is_ground_content = true
  def.drop = def.drop or "soil:"..name

  minetest.register_node("soil:"..name, def)
end

---
--- Registrations
---

-- [soil] Dirt
soil.register("dirt", {
  description = "Dirt",
  tiles = {"soil_dirt.png"},
  sounds = default.node_sound_dirt_defaults(),
})

-- [soil] Dirt with grass
soil.register("dirt_with_grass", {
  description = "Dirt with Grass",
	tiles = {"soil_grass.png", "soil_dirt.png", "soil_dirt.png^soil_grass_side.png"},
	drop = "soil:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

-- [soil] Dirt with grass footsteps
soil.register("dirt_with_grass_footsteps", {
  description = "Dirt with Grass and Footsteps",
	tiles = {"soil_grass_footsteps.png", "soil_dirt.png", "soil_dirt.png^soil_grass_side.png"},
	groups = {not_in_creative_inventory=1},
	drop = "soil:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

-- [soil] Dirt with snow
soil.register("dirt_with_snow", {
  description = "Dirt with Snow",
	tiles = {"default_snow.png", "soil_dirt.png", "soil_dirt.png^soil_snow_side.png"},
	drop = "soil:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
	}),
})

-- [soil] Sand
soil.register("sand", {
  description = "Sand",
	tiles = {"soil_sand.png"},
	groups = {soil=0, sand=1, falling_node=1},
	sounds = default.node_sound_sand_defaults(),
})

-- [soil] Desert sand
soil.register("desert_sand", {
  description = "Desert Sand",
	tiles = {"soil_desert_sand.png"},
	groups = {soil=0, sand=1, falling_node=1},
	sounds = default.node_sound_sand_defaults(),
})

-- [soil] Gravel
soil.register("gravel", {
  description = "Gravel",
	tiles = {"soil_gravel.png"},
	groups = {crumbly=2, falling_node=1, soil=0},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})
