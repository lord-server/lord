local table_has_key
	= table.has_key

local SL = minetest.get_mod_translator()

--[[
  TODO: Move I/O-related functions into a separate mod (lord_util?)
--]]

--[[
  Definitions
--]]

races = {
	save_path = minetest.get_worldpath() .. "/races.txt",
}

-- TODO: migrate to new ones (to `lord_races`)
races.name = lord_races.Name
races.list = {
	[races.name.SHADOW] = {
		name = SL("Shadow"),
		granted_privs = {"fly", "fast", "spawn_to", "choose_race"},
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
	granted_privs = {},  -- Contains privileges given by this mod.
	revoked_privs = {},
}

minetest.register_privilege("race", {
	description = "Ability to change race and gender of a player.",
	give_to_singleplayer= false,
})

local function ensure_table_struct()
	cache.granted_privs = cache.granted_privs or {}
	cache.revoked_privs = cache.revoked_privs or {}
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

-- Now faction is binded to race
function races.get_faction(name)
	local race = races.get_race(minetest.get_player_by_name(name))
	return races.factions[race]
end

--- @param player Player
function races.get_race(player)
	return character.of(player):get_race(races.default[1])
end

--- @param player Player
function races.set_race_and_gender(player, race_and_gender)
	local valid = races.validate(race_and_gender)
	if not valid then
		return false
	end

	local race = race_and_gender[1]
	local gender = race_and_gender[2]
	character.of(player)
		:set_race(race)
		:set_gender(gender)

	races.update_privileges(player:get_player_name(), races.list[race].granted_privs, races.list[race].revoked_privs)
--	races.update_player(name, race_and_gender, races.default_skin)

	return true
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

-- -------------------------------------------------------------------------------------------------

local has_several_spawns = not minetest.is_singleplayer() and minetest.settings:get_bool('dynamic_spawn', false)

--- @type lord_classes.form.ChooseRace
local ChooseRaceForm = dofile(minetest.get_modpath('lord_classes') .. '/form/ChooseRaceForm.lua')
--- @type lord_classes.form.ChooseSkin
local ChooseSkinForm = dofile(minetest.get_modpath('lord_classes') .. '/form/ChooseSkinForm.lua')
--- @type lord_classes.hud.Shadow
local ShadowHUD      = dofile(minetest.get_modpath('lord_classes') .. '/hud/Shadow.lua')

ChooseRaceForm.on_switch(function(form, race, gender)
	local name   = form.player_name
	local player = form:player()

	if has_several_spawns then
		if races.tp_process[name] ~= true then
			races.tp_process[name] = true
			minetest.after(0.1, function()
				if spawn.check_conf(race .. "_spawn_pos") then
					spawn.put_player_at_spawn(player, race .. "_spawn_pos")
				else
					spawn.put_player_at_spawn(player, "common_spawn_pos")
				end
				races.tp_process[name] = false
			end)
		end
	end
end)
ChooseRaceForm.on_apply(function(form, race, gender)
	local race_and_gender = { race, gender }
	-- TODO: character.of(form:player()):set_race(race)
	races.set_race_and_gender(form:player(), race_and_gender, true)
	races.show_skin_change_form(form:player(), race, gender, 1)
end)
ChooseRaceForm.on_cancel(function(form)
	local race_and_gender = races.default
	-- TODO: character.of(form:player()):set_race(race)
	races.set_race_and_gender(form:player(), race_and_gender, true)
	races.show_shadow_hud(form:player())
end)

ChooseSkinForm.on_apply(function(form, skin_no)
	character.of(form:player()):set_skin_no(skin_no)
end)
ChooseSkinForm.on_back(function(form)
	races.show_change_form(form:player())
end)

--- @param player Player
function races.show_change_form(player)
	local show_spawns_info = has_several_spawns
	ChooseRaceForm:new(player):open(show_spawns_info)
end
---@param player  Player
---@param race    string
---@param gender  string
---@param skin_no number
function races.show_skin_change_form(player, race, gender, skin_no)
	minetest.after(0.1, function()
		ChooseSkinForm:new(player, race, gender):open(skin_no)
	end)
end

--- @param player Player
function races.show_shadow_hud(player)
	local show_spawn_to = has_several_spawns

	ShadowHUD:for_player(player):show(show_spawn_to)
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

	player = minetest.get_player_by_name(player)
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


minetest.register_on_joinplayer(function(player)
	local race = character.of(player):get_race()
	if not race then
		races.show_change_form(player)

		return
	end

	if race == lord_races.Name.SHADOW then
		races.show_shadow_hud(player)
	end
end)

minetest.register_chatcommand("second_chance", {
	params = "",
	privs = {},
	description = SL("Second chance"),
	func = function(name, params)
		local player = minetest.get_player_by_name(name)
		local character = character.of(player)
		if not character:has_second_chance() then
			return false, SL("Won't give another chance")
		end

		races.show_change_form(player)
		character:set_has_second_chance(false)
	end
})

minetest.register_chatcommand('choose_race', {
	params = '',
	privs = { choose_race = true },
	description = SL(''),
	func = function(name, params)
		local player = minetest.get_player_by_name(name)
		if races.get_race(player) ~= races.name.SHADOW then
			return false, SL('Something went wrong. Only the Shadow can choose the race.')
		end

		ShadowHUD:for_player(player):hide()
		races.show_change_form(player)
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

		local player = minetest.get_player_by_name(args[1])
		if not player then
			return false, SL("Player '@1' is not online or does not exist", args[1])
		end

		races.show_change_form(player)
	end
})

dofile(minetest.get_modpath('lord_classes')..'/effects.lua')
