-- ocd/chatcommands.lua

-- [privelege] Gamemode
minetest.register_privilege("gamemode", "Ability to use /gamemode")

-- [command] Gamemode - /gamemode <mode>
minetest.register_chatcommand("gamemode", {
  description = "Change gamemode",
  params = "<gamemode> | <name> <gamemode>",
  privs = {gamemode=true},
  func = function(name, param)
		local params = param:split(" ")
		local player = minetest.get_player_by_name(name)
		local newgm

		if params and #params == 1 then
			newgm = params[1]
		elseif params and #params == 2 then
			if minetest.get_player_by_name(params[1]) then
				player = minetest.get_player_by_name(params[1])
				newgm  = params[2]
			end
		else
			return false, "Invalid usage (see /help gamemode)"
		end

		-- Set gamemode
		if ocd.set_gamemode(player, newgm) then
	    return true, "Set "..player:get_player_name().."'s gamemode to "..param
		else -- else, Return invalid gamemode
			return false, "Invalid gamemode: "..newgm
		end
  end,
})
