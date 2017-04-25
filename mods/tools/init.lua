-- tools/init.lua

tools = {}

---
--- API
---

-- [function] Register tool
function tools.register(name, def)
  -- Register tool
  minetest.register_tool("tools:"..name, def)
end

---
--- Registrations
---

-- [pick] Wood
tools.register("pick_wood", {
  description = "Wooden Pickaxe",
  inventory_image = "tools_woodpick.png",
  tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[3]=1.60}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})

-- [shovel] Wood
tools.register("shovel_wood", {
	description = "Wooden Shovel",
	inventory_image = "tools_woodshovel.png",
	wield_image = "tools_woodshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			crumbly = {times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})

-- [axe] Wood
tools.register("axe_wood", {
	description = "Wooden Axe",
	inventory_image = "tools_woodaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			choppy = {times={[2]=3.00, [3]=2.00}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})

-- [sword] Wood
tools.register("sword_wood", {
	description = "Wooden Sword",
	inventory_image = "tools_woodsword.png",
        on_use = function(data)
          print(data)
        end,
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})

-- [pick] Stone
tools.register("pick_stone", {
	description = "Stone Pickaxe",
	inventory_image = "tools_stonepick.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[2]=2.0, [3]=1.20}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
})

-- [shovel] Stone
tools.register("shovel_stone", {
	description = "Stone Shovel",
	inventory_image = "tools_stoneshovel.png",
	wield_image = "tools_stoneshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.4,
		max_drop_level=0,
		groupcaps={
			crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})

-- [axe] Stone
tools.register("axe_stone", {
	description = "Stone Axe",
	inventory_image = "tools_stoneaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=3.00, [2]=2.00, [3]=1.50}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
})

-- [sword] Stone
tools.register("sword_stone", {
	description = "Stone Sword",
	inventory_image = "tools_stonesword.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=4},
	},
})

-- [pick] Steel
tools.register("pick_steel", {
	description = "Steel Pickaxe",
	inventory_image = "tools_steelpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

-- [shovel] Steel
tools.register("shovel_steel", {
	description = "Steel Shovel",
	inventory_image = "tools_steelshovel.png",
	wield_image = "tools_steelshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

-- [axe] Steel
tools.register("axe_steel", {
	description = "Steel Axe",
	inventory_image = "tools_steelaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

-- [sword] Steel
tools.register("sword_steel", {
	description = "Steel Sword",
	inventory_image = "tools_steelsword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
})

-- [pick] Bronze
tools.register("pick_bronze", {
	description = "Bronze Pickaxe",
	inventory_image = "tools_bronzepick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

-- [shovel] Bronze
tools.register("shovel_bronze", {
	description = "Bronze Shovel",
	inventory_image = "tools_bronzeshovel.png",
	wield_image = "tools_bronzeshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

-- [axe] Bronze
tools.register("axe_bronze", {
	description = "Bronze Axe",
	inventory_image = "tools_bronzeaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

-- [sword] Bronze
tools.register("sword_bronze", {
	description = "Bronze Sword",
	inventory_image = "tools_bronzesword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	},
})

-- [pick] Mese
tools.register("pick_mese", {
	description = "Mese Pickaxe",
	inventory_image = "tools_mesepick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

-- [shovel] Mese
tools.register("shovel_mese", {
	description = "Mese Shovel",
	inventory_image = "tools_meseshovel.png",
	wield_image = "tools_meseshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

-- [axe] Mese
tools.register("axe_mese", {
	description = "Mese Axe",
	inventory_image = "tools_meseaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})

-- [sword] Mese
tools.register("sword_mese", {
	description = "Mese Sword",
	inventory_image = "tools_mesesword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
})

-- [pick] Diamond
tools.register("pick_diamond", {
	description = "Diamond Pickaxe",
	inventory_image = "tools_diamondpick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

-- [shovel] Diamond
tools.register("shovel_diamond", {
	description = "Diamond Shovel",
	inventory_image = "tools_diamondshovel.png",
	wield_image = "tools_diamondshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=30, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

-- [axe] Diamond
tools.register("axe_diamond", {
	description = "Diamond Axe",
	inventory_image = "tools_diamondaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})

-- [sword] Diamond
tools.register("sword_diamond", {
	description = "Diamond Sword",
	inventory_image = "tools_diamondsword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=40, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	},
})
