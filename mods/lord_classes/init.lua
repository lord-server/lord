local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

--[[
  TODO: Move file functions into a separate mod (lord_util?)
--]]

--[[
  Definitions
--]]
races = {
	save_path = minetest.get_worldpath() .. "/races.txt"
}

races.list = {
	shadow = {
		name = SL("Shadow"),
		granted_privs = {"fly", "fast"},
		revoked_privs = {"shout", "interact"},
		cannot_be_selected = true,
	},
	orc = {
		name = SL("Orc"),
	},
	man = {
		name = SL("Man"),
	},
	dwarf = {
		name = SL("Dwarf"),
	},
	hobbit = {
		name = SL("Hobbit"),
	},
	elf = {
		name = SL("Elf"),
	},
}

-- TODO: Get these values via minetest.setting_get()
races.default = {"shadow", "female"}

-- All data will be stored in this table
-- races.cache[player_name] = {"shadow", "female"}
races.cache = {
	players = {},
	granted_privs = {},  -- Contains privileges given by this mod.
	revoked_privs = {}
}

--[[
  Boilerplate functions
--]]

-- Load serialized classes from file
-- Returns false when failed, true otherwise
function races.load()
	local input = io.open(races.save_path, "r")
    if not input then
		return false
	end
    local content = input:read("*all")
    races.cache = minetest.deserialize(content)
    input:close()
	return true
end

races.load()

-- Serialize and save the races
-- Returns false when failed, true otherwise
function races.save()
	local output = io.open(races.save_path, "w")
	if not output then
		return false
	end
	local content = minetest.serialize(races.cache)
    output:write(content)
    output:close()
    return true
end

function table.contains(t, v)
	for k, _ in pairs(t) do
		if k == v then
			return true
		end
	end
	return false
end

-- Validates {race, gender} tables
-- Returns true if the table is valid, false otherwise
function races.validate(race_and_gender)
	local race = race_and_gender[1]
	local gender = race_and_gender[2]

	if table.contains(races.list, race) then
		if gender == "male" or gender == "female" then
			return true
		end
	end
	return false
end

-- Updates player visuals
function races.update_player(name, race_and_gender)
	local race = race_and_gender[1]
	local gender = race_and_gender[2]

	-- TODO: caching
	local texture = race .. "_" .. gender .. ".png" -- e.g. shadow_female.png
	multiskin[name].skin = texture
	multiskin:update_player_visuals(minetest.get_player_by_name(name))
end

-- Returns the race and the gender of specified player
function races.get_race_and_gender(name)
	return races.cache.players[name] or races.default
end

-- Tinker with privs
function races.update_privileges(name, granted_privs, revoked_privs)
	print("update_privileges")
	local privs = minetest.get_player_privs(name)
	print(dump(privs))

	-- Create tables if they don't exist
	races.cache.granted_privs[name] = races.cache.granted_privs[name] or {}
	races.cache.revoked_privs[name] = races.cache.revoked_privs[name] or {}

	-- Step #1: Restore normal privileges
	for priv_name, _ in pairs(privs) do
		if races.cache.granted_privs[name][priv_name] then
			races.cache.granted_privs[name][priv_name] = nil
			privs[priv_name] = nil
			print("1 Revoking ", priv_name)
		end
	end

	for priv_name, _ in pairs(races.cache.revoked_privs[name]) do
		races.cache.revoked_privs[name][priv_name] = nil
		privs[priv_name] = true
		print("1 Granting", priv_name)
	end

	-- Step #2: Grant/revoke new privileges
	if granted_privs then
		for _, priv_name in pairs(granted_privs) do
			if not privs[priv_name] then  -- Player hasn't this privilege
				privs[priv_name] = true
				races.cache.granted_privs[name][priv_name] = true
				print("2 Granting", priv_name)
			end
		end
	end

	if revoked_privs then
		for _, priv_name in pairs(revoked_privs) do
			privs[priv_name] = nil
			races.cache.revoked_privs[name][priv_name] = true
			print("2 Revoking", priv_name)
		end
	end
	print("= PRIVS OF", name)
	print(dump(privs))
	minetest.set_player_privs(name, privs)
end

function races.set_race_and_gender(name, race_and_gender, should_cache)
	local valid = races.validate(race_and_gender)
	if not valid then
		return false
	end

	local race = race_and_gender[1]

	-- if races.list[race].granted_privs or races.list[race].revoked_privs then
		races.update_privileges(name, races.list[race].granted_privs,
		                        races.list[race].revoked_privs)
	-- end

	races.cache.players[name] = race_and_gender
	races.update_player(name, race_and_gender)

	return true
end

-- Converts user-friendly names to the corresponding internal names
-- Will return default values if the input is incorrect
-- E.g. Shadow -> shadow, Male -> male
function races.to_internal(race, gender)
	local _race = races.default[1]
	local _gender = races.default[2]

	for internal_name, def in pairs(races.list) do
		if def.name == race then
			_race = internal_name
		end
	end

	if gender == SL("Female") then
		_gender = "female"
	elseif gender == SL("Male") then
		_gender = "male"
	end

	return {_race, _gender}
end

-- The form
function races.show_change_form(name)
	local form = "size[7,4]"..
				 "background[7,4;1,1;gui_formbg.png;true]"

	local list = {}
	for _, def in pairs(races.list) do
		if not def.cannot_be_selected then  -- Exclude "shadow"
			table.insert(list, def.name)
		end
	end

	local races_list = table.concat(list, ",")

	form = form..
		"label[0,0;"..minetest.formspec_escape(SL("Please select the race you wish to be:")).."]"..
		"dropdown[0.0,2.3;3.0,1.0;race;"..races_list..";1]"..
		"dropdown[4.0,2.3;3.0,1.0;gender;"..SL("Male")..","..SL("Female")..";1]"..
		"button_exit[0.0,3.3;3.0,1.0;cancel;"..SL("Cancel").."]"..
		"button_exit[4.0,3.3;3.0,1.0;ok;"..SL("Ok").."]"

	minetest.show_formspec(name, "change_race", form)
end

-- Обработка событий формы
minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	if formname == "change_race" then
		if fields.ok then -- OK button pressed
			r = races.to_internal(fields.race, fields.gender)
			races.set_race_and_gender(name, r, true)

			-- This message will become user-friendly after translating
			minetest.chat_send_player(name, "change_" .. r[1] .. "_" .. r[2])
			minetest.log("action", name .. " became a " .. r[1] .. " " .. r[2])
			races.save()
		elseif fields.quit then
			races.set_race_and_gender(name, races.default, false)
			minetest.chat_send_player(name, SL("change_" .. races.default[1]..
			                          "_" .. races.default[2]))
			minetest.log("action", name .. " became a " .. races.default[1]..
			             " " .. races.default[2])
			-- Don't save, so player can change the race later
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()

	if table.contains(races.cache.players, name) then  -- Player is registered already
		r = races.get_race_and_gender(name)
		if races.list[r[1]].cannot_be_selected then
			races.show_change_form(name)
			return
		end
		races.set_race_and_gender(name, races.get_race_and_gender(name), true)
	else
		races.show_change_form(name)
	end
end)

minetest.register_chatcommand("race", { -- изменение расы любому игроку
	params = "<player name> <new race> <new gender>",
	privs = {},
	description = SL("Change the race of any player"),
	func = function(name, params)

	end
})

if minetest.setting_getbool("msg_loading_mods") then
	minetest.log("action", minetest.get_current_modname().." loaded")
end
