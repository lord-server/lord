local SL = lord.require_intllib()

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

--Spawn

minetest.register_chatcommand("spawn", {
	description = SL("Teleport to the spawn location"),
	func = function(name, _)
		local ok = put_player_at_spawn(minetest.get_player_by_name(name))
		if ok then
			return true, SL("Teleporting to spawn...")
		end
		return false, SL("Teleport failed")
	end
})

--Hall of Life

minetest.register_chatcommand("life", {
	description = SL("Teleport to the Hall of Life"),
	func = function(name, _)
		local ok = put_player_at_spawn(minetest.get_player_by_name(name))
		if ok then
			return true, SL("Teleporting to Hall of Life...")
		end
		return false, SL("Teleport failed")
	end
})

--Hall of Death

local death = "hall_of_death_pos"

local function tp_to_hall_of_death(obj)
	if not check_spawnpoint(death) then
		return false
	end

	local hall_of_death = minetest.setting_get_pos(death)

	minetest.log('action', "Moving "..obj:get_player_name()..
			" to "..death.." at "..
			minetest.pos_to_string(hall_of_death))

	obj:setpos(hall_of_death)

	return true
end

if check_spawnpoint(death) then
	minetest.register_chatcommand("death", {
		description = SL("Teleport to the Hall of Death"),
		func = function(name, _)
			local ok = tp_to_hall_of_death(minetest.get_player_by_name(name))
			if ok then
				return true, SL("Teleporting to Hall of Death...")
			end
			return false, SL("Teleport failed")
		end
	})
end

minetest.register_on_newplayer(function(obj)
	return put_player_at_spawn(obj)
end)

minetest.register_on_respawnplayer(function(obj)
	return put_player_at_spawn(obj)
end)

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action",
	minetest.get_current_modname().." mod LOADED") end
