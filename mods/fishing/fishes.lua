-----------------------------------------------------------------------------------------------
-- Fish
-----------------------------------------------------------------------------------------------
minetest.register_craftitem("fishing:fish_raw", {
	description = "Fish",
    groups = {},
    inventory_image = "fishing_fish.png",
	 on_use = minetest.item_eat(2),
})

-----------------------------------------------------------------------------------------------
-- Roasted Fish
-----------------------------------------------------------------------------------------------
minetest.register_craftitem("fishing:fish", {
	description = "Roasted Fish",
    groups = {},
    inventory_image = "fishing_fish_cooked.png",
	 on_use = minetest.item_eat(4),
})

-----------------------------------------------------------------------------------------------
-- Sushi
-----------------------------------------------------------------------------------------------
minetest.register_craftitem("fishing:sushi", {
	description = "Sushi (Hoso Maki)",
    groups = {},
    inventory_image = "fishing_sushi.png",
	 on_use = minetest.item_eat(8),
})

