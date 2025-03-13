local table_has_key
	= table.has_key

local SL = minetest.get_mod_translator()

--[[
  TODO: Move I/O-related functions into a separate mod (lord_util?)
--]]

--[[
  Definitions
--]]

local form_header = "size[7,4]"

races = {
	save_path = minetest.get_worldpath() .. "/races.txt",
	update_cbs = {},
	init_cbs = {},
}

-- TODO: migrate to new ones (to `lord_races`)
races.name = lord_races.Name
races.list = {
	[races.name.SHADOW] = {
		name = SL("Shadow"),
		granted_privs = {"fly", "fast"},
		revoked_privs = {"shout", "interact"},
		cannot_be_selected = true,
		no_corpse = true,
		faction = "neutral",
	},
	[races.name.ORC] = {
		name = SL("Orc"),
		faction = "monster",
	},
	[races.name.HUMAN] = {
		name = SL("Man"),
		faction = "npc",
	},
	[races.name.DWARF] = {
		name = SL("Dwarf"),
		faction = "npc",
	},
	[races.name.HOBBIT] = {
		name = SL("Hobbit"),
		faction = "npc",
	},
	[races.name.ELF] = {
		name = SL("Elf"),
		faction = "npc",
	},
}

-- TODO: Get these values via minetest.settings:get()
races.default = { races.name.SHADOW, "male" }
races.default_skin = 1

local tmp_races_list = {}
for name, _ in pairs(races.list) do
	table.insert(tmp_races_list, name)
end

races.factions = {}

for name, desc in pairs(races.list) do
	races.factions[name] = desc.faction
end

-- A string contaning possible race values
races.list_str = table.concat(tmp_races_list, ", ")

-- All data will be stored in this table
-- cache.players[player_name] = {"shadow", "female"}
-- cache.granted_privs[player_name] = {"fly", "fast"}
-- cache.revoked_privs[player_name] = {"shout", "interact"}
local cache = {
	players = {},
	granted_privs = {},  -- Contains privileges given by this mod.
	revoked_privs = {},
	can_change = {},  -- {foo=true, bar=false}
	skins = {}, -- {foo=1, bar=4}
}

minetest.register_privilege("race", {
	description = "Ability to change race and gender of a player.",
	give_to_singleplayer= false,
})

local function ensure_table_struct()
	cache.players = cache.players or {}
	cache.granted_privs = cache.granted_privs or {}
	cache.revoked_privs = cache.revoked_privs or {}
	cache.can_change = cache.can_change or {}
	cache.skins = cache.skins or {}
end

-- Load serialized classes from file
-- Returns false when failed, true otherwise
function races.load()
    local content = io.read_from_file(races.save_path)
	if not content then	return false end

	cache = minetest.deserialize(content)

	return true
end

races.load()
ensure_table_struct()

-- Serialize and save the races
-- Returns false when failed, true otherwise
function races.save()
	local content = minetest.serialize(cache)
	local wrote, error_code, error_message = io.write_to_file(races.save_path, content)
	if not wrote then
		minetest.log("error", string.format(
			"Can't write to file `%s`: [%s]: %s", races.save_path, error_code, error_message
		))

		return false
	end

    return true
end

-- Validates {race, gender} tables
-- Returns true if the table is valid, false otherwise
function races.validate(race_and_gender)
	local race = race_and_gender[1]
	local gender = race_and_gender[2]

	if table_has_key(races.list, race) then
		if gender == "male" or gender == "female" then
			return true
		end
	end
	return false
end

-- Updates player visuals
function races.update_player(name, race_and_gender, skin)
	local race = race_and_gender[1]
	local gender = race_and_gender[2]

	-- TODO: caching
	local texture = lord_skins.get_texture_name(race, gender, skin) -- e.g. shadow_female.png
	local face = lord_skins.get_preview_name('front' ,race, gender, skin)

	for _, cb in ipairs(races.update_cbs) do
		cb(name, race, gender, skin, texture, face)
	end
end

function races.init_player(name, race_and_gender, skin)
	local race = race_and_gender[1]
	local gender = race_and_gender[2]

	-- TODO: caching
	local texture = lord_skins.get_texture_name(race, gender, skin) -- e.g. shadow_female.png
	local face = lord_skins.get_preview_name('front', race, gender, skin)

	for _, cb in ipairs(races.init_cbs) do
		cb(name, race, gender, skin, texture, face)
	end
end


function races.register_update_callback(cb)
	if cb == nil then
		-- fool proof
		minetest.log("Trying to register nil callback")
		return
	end
	table.insert(races.update_cbs, cb)
end

function races.register_init_callback(cb)
	if cb == nil then
		-- fool proof
		minetest.log("Trying to register nil callback")
		return
	end
	table.insert(races.init_cbs, cb)
end

-- Returns the race and the gender of specified player
function races.get_race_and_gender(name)
	return cache.players[name] or races.default
end

-- Now faction is binded to race
function races.get_faction(name)
	local race = races.get_race_and_gender(name)[1]
	return races.factions[race]
end

function races.get_race(name)
	return races.get_race_and_gender(name)[1]
end

function races.get_gender(name)
	return races.get_race_and_gender(name)[2]
end

function races.set_race_and_gender(name, race_and_gender, show_message)
	local valid = races.validate(race_and_gender)
	if not valid then
		return false
	end

	local race = race_and_gender[1]
	races.update_privileges(name, races.list[race].granted_privs,
		races.list[race].revoked_privs)

	cache.players[name] = race_and_gender
--	races.update_player(name, race_and_gender, races.default_skin)

	-- Notify player
	if show_message then
		minetest.chat_send_player(name, SL("change_" .. race))
	end

	return true
end

function races.get_skin_number(name)
	return cache.skins[name] or races.default_skin
end

function races.set_skin(name, skin_number)
	cache.skins[name] = skin_number
	races.update_player(name, races.get_race_and_gender(name), skin_number)
end

-- Tinker with privs
function races.update_privileges(name, granted_privs, revoked_privs)
	local privs = minetest.get_player_privs(name)

	-- Create tables if they don't exist
	cache.granted_privs[name] = cache.granted_privs[name] or {}
	cache.revoked_privs[name] = cache.revoked_privs[name] or {}

	-- Step #1: Restore normal privileges
	for priv_name, _ in pairs(privs) do
		if cache.granted_privs[name][priv_name] then
			cache.granted_privs[name][priv_name] = nil
			privs[priv_name] = nil
		end
	end

	for priv_name, _ in pairs(cache.revoked_privs[name]) do
		cache.revoked_privs[name][priv_name] = nil
		privs[priv_name] = true
	end

	-- Step #2: Grant/revoke new privileges
	if granted_privs then
		for _, priv_name in pairs(granted_privs) do
			if not privs[priv_name] then  -- Player hasn't this privilege
				privs[priv_name] = true
				cache.granted_privs[name][priv_name] = true
			end
		end
	end

	if revoked_privs then
		for _, priv_name in pairs(revoked_privs) do
			privs[priv_name] = nil
			cache.revoked_privs[name][priv_name] = true
		end
	end

	minetest.set_player_privs(name, privs)
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
	local form = form_header

	local list = {}
	for _, def in pairs(races.list) do
		if not def.cannot_be_selected then  -- Exclude "shadow"
			table.insert(list, def.name)
		end
	end

	local races_list = table.concat(list, ",")

	if not minetest.settings:get_bool("dynamic_spawn") then
		form = form .. string.format(
			"label[0,0;%s]"..  -- Information label
			"dropdown[0.0,2.3;3.0,1.0;race;%s;1]"..  -- Race dropdown
			"dropdown[4.0,2.3;3.0,1.0;gender;%s,%s;1]"..  -- Gender dropdown
			"button_exit[0.0,3.3;3.0,1.0;cancel;%s]"..  -- Cancel button
			"button_exit[4.0,3.3;3.0,1.0;ok;%s]",  -- OK button
			minetest.formspec_escape(SL("Please select the race you wish to be:")),
			races_list, SL("Male"), SL("Female"), SL("Cancel"), SL("OK")
		)
	else
		form = form .. string.format(
			"label[0,0;%s]"..  -- Information label
			"dropdown[0.0,2.3;3.0,1.0;race;%s;1]"..  -- Race dropdown
			"dropdown[4.0,2.3;3.0,1.0;gender;%s,%s;1]"..  -- Gender dropdown
			"label[0,0.5;%s]"..
			"button_exit[0.0,3.3;3.0,1.0;cancel;%s]"..  -- Cancel button
			"button_exit[4.0,3.3;3.0,1.0;ok;%s]",  -- OK button
			minetest.formspec_escape(SL("Please select the race you wish to be:")),
			races_list, SL("Male"), SL("Female"),
			minetest.colorize("#ff033e", SL("(Warning: choosing the race will teleport \n"..
			"you at the race spawn!)")),
			SL("Cancel"), SL("OK")
		)
	end
	minetest.show_formspec(name, "change_race", form)
end

-- Generates number sequence starting with 1 and ending with `max`
local function generate_sequence(max)
	local t = {}
	for i = 1, max do
		table.insert(t, i)
	end
	return table.concat(t, ",")
end

function races.show_skin_change_form(race, gender, skin, name)
	local form = form_header

	form = form .. string.format(
		"label[0,0;%s]"..
		"image[0.0,0.5;3.3,3.0;%s]"..
		"dropdown[3.6,0.51;3.0,1.0;skin;%s;%d]"..
		"button_exit[0.0,3.3;3.0,1.0;back;%s]"..
		"button_exit[4.0,3.3;3.0,1.0;ok;%s]",

		SL("Choose a skin for your character:"),
		lord_skins.get_preview_name('both', race, gender, skin),
		generate_sequence(lord_skins.get_skins_count(race, gender)), skin,
		SL("Back"),
		SL("OK")
	)
	minetest.after(0.1, minetest.show_formspec, name, "change_skin", form)
end

--- Обработчик открытия чего-либо расового (сундуков, дверей и др.).
--- Игрок может открыть сундук, если он принадлежит расе `owner_race` или провёл удачный взлом с помощью отмычки.
--- Два возвращаемых значения:
--- 1. булево значение (открыт ли сундук) или nil при ошибке;
--- 2. локализованное название расы, которой принадлежит сундук/дверь/..., если не удалось открыть (без взлома),
---    или nil, если взлом не удался или удалось открыть.
---
---@param owner_race string    ID расы, которой принадлежит сундук.
---@param player     string    никнейм игрока.
---@param itemstack  ItemStack предмет в руке игрока.
---
---@return boolean|nil, string|nil
function races.can_open_stuff(owner_race, player, itemstack)
	assert(races.list[owner_race], string.format("unknown race - \"%s\"", owner_race))

	if races.get_race(player) == owner_race or minetest.check_player_privs(player, "race") then
		return true, nil
	end

	if itemstack:get_name() == "lottblocks:lockpick" then
		if lottblocks.lockpick_can_break_in(itemstack, player) then
			return true, nil
		end
		return false, nil
	else
		return false, races.list[owner_race].name
	end
end

races.tp_process = {}

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	if formname == "change_race" then
		if fields.race and not fields.ok and not fields.quit and not fields.cancel then
			local r = races.to_internal(fields.race, fields.gender)
			if r then races.set_race_and_gender(name, r, true) end

			if minetest.settings:get_bool("dynamic_spawn") == true then
				if races.tp_process[name] ~= true then
					--minetest.chat_send_player(name, SL("Teleporting to Spawn..."))
					races.tp_process[name] = true
					minetest.after(1, function()
						if spawn.check_conf(r[1].."_spawn_pos") then
							spawn.put_player_at_spawn(player, r[1].."_spawn_pos")
						else
							spawn.put_player_at_spawn(player, "common_spawn_pos")
						end
						races.tp_process[name] = false
						--minetest.after(1, function()
							--races.show_skin_change_form(r[1], r[2], 1, name)
						--end)
					end)
				end
			end
		end
		if fields.ok then -- OK button pressed
			local r = races.to_internal(fields.race, fields.gender)
			races.set_race_and_gender(name, r, true)
			races.show_skin_change_form(r[1], r[2], 1, name)
		else -- Cancel button pressed, or escape pressed
			local r = races.default
			races.set_race_and_gender(name, r, true)
		end
	end
	if formname == "change_skin" then
		if fields.back then
			minetest.after(0.1, races.show_change_form, name)
		elseif fields.ok then
			races.set_skin(name, tonumber(fields.skin))
			races.save()
		elseif fields.skin then
			local r = races.get_race_and_gender(name)
			minetest.after(0.1, races.show_skin_change_form, r[1], r[2], tonumber(fields.skin), name)
		end
	end
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()

	if table_has_key(cache.players, name) then  -- Player is registered already
		local r = races.get_race_and_gender(name)
		if races.list[r[1]].cannot_be_selected then
			races.show_change_form(name)
			races.init_player(name, r, races.get_skin_number(name))
			return
		end
		r = races.get_race_and_gender(name)
		races.set_race_and_gender(name, r, false)
		-- Player is registered, but has no skin
		if cache.skins[name] == nil then
			cache.skins[name] = races.default_skin
		end

		races.init_player(name, r, races.get_skin_number(name))
	else
		races.show_change_form(name)
		cache.can_change[name] = true
		local r = races.get_race_and_gender(name)
		races.init_player(name, r, races.get_skin_number(name))
	end
end)

minetest.register_chatcommand("second_chance", {
	params = "",
	privs = {},
	description = SL("Second chance"),
	func = function(name, params)
		if cache.can_change[name] == nil then
			cache.can_change[name] = true
		end
		if not cache.can_change[name] then
			return false, SL("Won't give another chance")
		end
		races.show_change_form(name)
		cache.can_change[name] = false
	end
})

minetest.register_chatcommand("give_chance", {
	params = SL("<player name>"),
	privs = {race=true},
	description = string.format(SL("Give another chance to a player."), races.list_str),
	func = function(name, params)
		-- Parse arguments
		local args = {}
		for arg in params:gmatch("[^%s]+") do
			table.insert(args, arg)
		end

		-- Throw an error if there are too few arguments
		if #args < 1 then
			return false, string.format(
				SL("Too few arguments. Try %s to show the correct usage"),
				"/help give_chance")
		end

		-- Check if player exists
		if not cache.players[args[1]] then
			return false, string.format(SL("Player '%s' does not exist"), args[1])
		end

		races.show_change_form(args[1])
	end
})

dofile(minetest.get_modpath('lord_classes')..'/effects.lua')
