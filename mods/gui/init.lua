-- gui/init.lua

gui = {}

local modpath = minetest.get_modpath("gui")

-- [on join] Configure hotbar
minetest.register_on_joinplayer(function(player)
  player:hud_set_hotbar_image("gui_hotbar_bg.png")
  player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
end)

-- Load formspec API
dofile(modpath.."/formspec.lua")
