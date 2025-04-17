local SL = minetest.get_mod_translator()


races = {}

races.shadow_privileges = {
	granted_privileges = { 'fly', 'fast', 'spawn_to', 'choose_race' },
	revoked_privileges = { 'shout', 'interact' },
}

-- TODO: migrate to new ones (to `lord_races`)
races.name = lord_races.Name
races.list = {
	[races.name.SHADOW] = {
		name = SL("Shadow"),
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

races.default = {
	race = races.name.SHADOW,
	gender = 'male',
	skin_no = 1,
}

races.factions = {}

for name, desc in pairs(races.list) do
	races.factions[name] = desc.faction
end

minetest.register_privilege("race", {
	description = "Ability to change race and gender of a player.",
	give_to_singleplayer= false,
})

-- Now faction is binded to race
function races.get_faction(name)
	local race = character.of(minetest.get_player_by_name(name)):get_race()
	return races.factions[race]
end

--- @param privileges table<string,boolean>
--- @param to_remove  string[]
local function remove_privileges(privileges, to_remove)
	for _, privilege_name in pairs(to_remove) do
		privileges[privilege_name] = nil
	end
end
--- @param privileges table<string,boolean>
--- @param to_add     string[]
local function add_privileges(privileges, to_add)
	for _, privilege_name in pairs(to_add) do
		privileges[privilege_name] = true
	end
end

--- @param player   Player
--- @param old_race string
--- @param new_race string
function races.update_privileges(player, old_race, new_race)
	local player_name = player:get_player_name()
	local privileges  = minetest.get_player_privs(player_name)

	if old_race == lord_races.Name.SHADOW then
		remove_privileges(privileges, races.shadow_privileges.granted_privileges)
		add_privileges(privileges, races.shadow_privileges.revoked_privileges)
	end
	if new_race == lord_races.Name.SHADOW then
		remove_privileges(privileges, races.shadow_privileges.revoked_privileges)
		add_privileges(privileges, races.shadow_privileges.granted_privileges)
	end

	minetest.set_player_privs(player_name, privileges)
end

-- -------------------------------------------------------------------------------------------------
--- @type lord_classes.form.ChooseRace
local ChooseRaceForm = dofile(minetest.get_modpath('lord_classes') .. '/form/ChooseRaceForm.lua')
--- @type lord_classes.form.ChooseSkin
local ChooseSkinForm = dofile(minetest.get_modpath('lord_classes') .. '/form/ChooseSkinForm.lua')
--- @type lord_classes.hud.Shadow
local ShadowHUD      = dofile(minetest.get_modpath('lord_classes') .. '/hud/Shadow.lua')

-- TODO: move to `lord_spawns` mod
local has_several_spawns = not minetest.is_singleplayer() and minetest.settings:get_bool('dynamic_spawn', false)
races.tp_process = {}
--- @param player Player
--- @param race   string
local function move_player_to_spawn(player, race)
	local name = player:get_player_name()
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
--- @return string one of lord_races.Name.<CONST>
local function get_random_race()
	local available_races = table.keys(table.except(lord_races.get_player_races(),	{ lord_races.Name.SHADOW }))

	return available_races[math.random(1, #available_races)]
end
ChooseRaceForm.on_switch(function(form, race, gender)
	local player = form:player()

	if has_several_spawns then
		move_player_to_spawn(player, race)
	end
end)
-- TODO: end

ChooseRaceForm.on_apply(function(form, race, gender)
	local skin_no = races.default.skin_no
	character.of(form:player())
		:set_race(race)
		:set_gender(gender)
		:set_skin_no(skin_no)

	races.show_skin_change_form(form:player(), race, gender, skin_no)
end)
ChooseRaceForm.on_cancel(function(form)
	local race   = races.default.race
	local gender = races.default.gender
	character.of(form:player())
		:set_race(race)
		:set_gender(gender)
		:set_skin_no(races.default.skin_no)

	races.show_shadow_hud(form:player())
end)

ChooseSkinForm.on_switch(function(form, skin_no)
	character.of(form:player()):set_skin_no(skin_no)
end)
ChooseSkinForm.on_apply(function(form, skin_no)
	character.of(form:player()):set_skin_no(skin_no)
end)
ChooseSkinForm.on_back(function(form)
	character.of(form:player()):set_skin_no(nil)
	races.show_change_form(form:player())
end)

character.on_race_change(function(character, race, old_race)
	races.update_privileges(character:get_player(), old_race, race)
end)

--- @param player Player
function races.show_change_form(player, selected_race)
	local show_spawns_info = has_several_spawns
	selected_race = selected_race or character.of(player):get_race()
	ChooseRaceForm:new(player):open(show_spawns_info, selected_race)
end
---@param player  Player
---@param race    string
---@param gender  string
---@param skin_no number
function races.show_skin_change_form(player, race, gender, skin_no)
	ChooseSkinForm:new(player, race, gender):open(skin_no)
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
---@param player     Player    ObjectRef игрока.
---@param itemstack  ItemStack предмет в руке игрока.
---
---@return boolean|nil, string|nil
function races.can_open_stuff(owner_race, player, itemstack)
	assert(races.list[owner_race], string.format("unknown race - \"%s\"", owner_race))

	if character.of(player):get_race() == owner_race or minetest.check_player_privs(player, "race") then
		return true, nil
	end

	if itemstack:get_name() == "lottblocks:lockpick" then
		if lottblocks.lockpick_can_break_in(itemstack, player:get_player_name()) then
			return true, nil
		end
		return false, nil
	else
		return false, races.list[owner_race].name
	end
end

minetest.register_on_joinplayer(function(player)
	local race = character.of(player):get_race()
	if not race then
		-- Random chosen race for select in ChooseRaceForm & for tp to spawn
		if has_several_spawns then
			race = get_random_race()
			move_player_to_spawn(player, race)
		end
		races.show_change_form(player, race)

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
		if character.of(player):get_race() ~= races.name.SHADOW then
			return false, SL('Something went wrong. Only the Shadow can choose the race.')
		end

		ShadowHUD:for_player(player):hide()
		-- Random chosen race for select in ChooseRaceForm & for tp to spawn
		local race
		if has_several_spawns then
			race = get_random_race()
			move_player_to_spawn(player, race)
		end
		races.show_change_form(player, race)
	end
})

minetest.register_chatcommand("give_chance", {
	params = SL("<player name>"),
	privs = {race=true},
	description = SL("Give another chance to a player."),
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
