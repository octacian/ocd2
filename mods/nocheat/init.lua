--NoCheat Mod v1.0
--Released under GPLv2

dofile(minetest.get_modpath(minetest.get_current_modname()).."/settings.lua")

local ncs = nocheat_settings

local function log(t, m)
	if m == nil then
		minetest.log("[NoCheat] "..t)
	else
		minetest.log(t, "[NoCheat] "..m)
	end
end

if not minetest.register_on_cheat then
	error("The Minetest version you're using is too old for NoCheat")
end

local dbpath = minetest.get_worldpath().."/nocheat.db"

local db = {
	users = {},
}

local function savedb()
	local f, err = io.open(dbpath, "w")
	if not f then
		log("error", "Could not save database: "..err)
	end
	f:write(minetest.serialize(db))
	f:close()
end

local function loaddb()
	local f, err = io.open(dbpath, "r")
	if not f then
		log("error", "Could not load database: "..err)
	end
	db = minetest.deserialize(f:read("*a"))
	f:close()
end

local function notify_hack(str, player)
	log("action", str)
	if ncs.public_notify then
		minetest.chat_send_all("[NoCheat] " .. str)
	end
	if ncs.player_notify then
		minetest.chat_send_player(player, "[NoCheat] " .. str, false)
	end
end

local function checkforauto(pname)
	if db.users[pname].vl > ncs.auto_limit and ncs.autoban and not db.users[pname].action then
		db.users[pname].action = true
		log("action", "Banning " .. pname .. " because of VL " .. db.users[pname].vl .. " (> " .. ncs.auto_limit .. ")")
		minetest.chat_send_player(pname, "[NoCheat] Your VL went too high, you will get banned now", false)
		minetest.chat_send_player(pname, "Disconnect will follow shortly, have a nice day :)", false)
		minetest.after(5, function(n)
			if ncs.public_ban_notify then
				minetest.chat_send_all(n .. " was banned for hacking")
			end
			minetest.ban_player(n)
		end, pname)
	end
	if db.users[pname].vl > ncs.auto_limit and ncs.autorevoke and minetest.check_player_privs(pname, {interact=true}) and not db.users[pname].action then
		db.users[pname].action = true
		log("action", "Revoking interact from " .. pname .. " because of VL " .. db.users[pname].vl .. " (> " .. ncs.auto_limit .. ")")
		minetest.chat_send_player(pname, "[NoCheat] Your VL went too high, your 'interact' privilege was revoked", false)
		minetest.chat_send_player(pname, "Have a nice day :)", false)
		local p = minetest.get_player_privs(pname)
		p.interact = nil
		minetest.set_player_privs(pname, p)
	end
end

local f = io.open(dbpath, "r")
if f then
	f:close()
	loaddb()
end
f = nil

minetest.register_chatcommand("vlreset", {
    params = "<name>",
    description = "Reset VL value for player",
    privs = {privs = true},
    func = function(name, param)
    	if db.users[param] == nil then
    		minetest.chat_send_player(name, "Player not found in NoCheat database")
    		return
    	end
    	db.users[param].vl = 0
    	db.users[param].action = false
    	savedb()
    	minetest.chat_send_player(name, "done")
    end,
})

minetest.register_chatcommand("vlget", {
    params = "<name>",
    description = "Get VL value for player",
    privs = {privs = true},
    func = function(name, param)
    	if db.users[param] == nil then
    		minetest.chat_send_player(name, "Player not found in NoCheat database")
    		return
    	end
    	minetest.chat_send_player(name, "VL of "..param.." is "..db.users[param].vl)
    end,
})

minetest.register_privilege("maycheat", "User is ignored by NoCheat")

minetest.register_on_cheat(function(player, cheat)
	local pname = player:get_player_name()
	if minetest.check_player_privs(pname, {maycheat=true}) then
		return
	end
	if db.users[pname] == nil then
		db.users[pname] = {
			vl = 0,
			action = false,
		}
	end
	if db.users[pname].action then
		return
	end
	if cheat.type == "dug_too_fast" then
		notify_hack(pname .. " has dug too fast (VL " .. ncs.vlsettings[cheat.type] .. ")", pname)
		db.users[pname].vl = db.users[pname].vl + ncs.vlsettings[cheat.type]
	elseif cheat.type == "dug_unbreakable" then
		notify_hack(pname .. " tried to dig an unbreakable node (VL " .. ncs.vlsettings[cheat.type] .. ")", pname)
		db.users[pname].vl = db.users[pname].vl + ncs.vlsettings[cheat.type]
	elseif cheat.type == "moved_too_fast" then
		notify_hack(pname .. " moved too fast (VL " .. ncs.vlsettings[cheat.type] .. ")", pname)
		db.users[pname].vl = db.users[pname].vl + ncs.vlsettings[cheat.type]
	elseif cheat.type == "interacted_too_far" then
		notify_hack(pname .. " interacted too far (VL " .. ncs.vlsettings[cheat.type] .. ")", pname)
		db.users[pname].vl = db.users[pname].vl + ncs.vlsettings[cheat.type]
	elseif cheat.type == "finished_unknown_dig" then
		notify_hack(pname .. " finished unknown dig (VL " .. ncs.vlsettings[cheat.type] .. ")", pname)
		db.users[pname].vl = db.users[pname].vl + ncs.vlsettings[cheat.type]
	end
	checkforauto(pname)
	savedb()
end)

print("[NoCheat] Loaded!")
