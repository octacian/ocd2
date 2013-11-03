--NoCheat settings

nocheat_settings = {
	autoban = false, -- Whether players are automatically banned if they reach a specific VL
	autorevoke = true, -- Whether players are automatically revoked 'interact' priv if they reach a specific VL
	auto_limit = 425, -- the "specific VL" referenced in the 2 above sentence
	public_ban_notify = true, -- Whether a ban because of a too high VL will be announced publicy
	public_notify = false, -- Whether the detection of hacking is publicy announced in chat
	player_notify = false, -- Whether the player gets notified if it hacking was detected

	--VL Settings(Advanced)
	--Only change these if you know what you are doing
	vlsettings = {
		dug_too_fast         = 20,
		dug_unbreakable      = 50,
		moved_too_fast       = 10,
		interacted_too_far   =  5,
		finished_unknown_dig = 25,
	},
}
