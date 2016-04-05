local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

-- Some modified from: Minetest: builtin/static_spawn.lua

local function check_spawnpoint(config_setting)
	if not minetest.setting_get(config_setting) then
		minetest.log('error', "The \"" .. config_setting .. "\" setting is not set")
		return false
	end

	if not minetest.setting_get_pos(config_setting) then
		minetest.log('error', "The " .. config_setting .. " setting is invalid: \""..
				core.setting_get(config_setting).."\"")
		return false
	end
	return true
end


local function put_player_at_spawn(obj)

	local config_setting

	-- players with interact spawn at the location specified by
	-- "alt_spawnpoint" in the .conf file. Those *without* interact go to
	-- "static_spawnpoint".

	if not minetest.get_player_privs(obj:get_player_name()).interact then
		config_setting  = "static_spawnpoint"
	else
		config_setting  = "alt_spawnpoint"
	end

	if not check_spawnpoint(config_setting) then
		return false
	end

	local spawnpoint = minetest.setting_get_pos(config_setting)

	minetest.log('action', "Moving " .. obj:get_player_name() ..
			" to " .. config_setting .. " at "..
			minetest.pos_to_string(spawnpoint))

	obj:setpos(spawnpoint)

	return true
end


minetest.register_chatcommand("spawn", {
	description = SL("Teleport to the spawn location"),
	func = function(name, _)
		local ok = put_player_at_spawn(minetest.get_player_by_name(name))
		if ok then
			return true, "Teleporting to spawn..."
		end
		return false, "Teleport failed"
	end
})


minetest.register_on_newplayer(function(obj)
	return put_player_at_spawn(obj)
end)

minetest.register_on_respawnplayer(function(obj)
	return put_player_at_spawn(obj)
end)

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
