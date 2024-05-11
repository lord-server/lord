--- @class clans.Clan
--- @field public title string
--- @field public players table<number,string>

--- @type StorageRef
local clan_storage = minetest.get_mod_storage()

-- HACK: this is a quick hardcoded local storage for clans data
-- TODO: commands for manage
--- @type table<string,clans.Clan>|clans.Clan[]
--[[local clans_storage = {
	masons = {
		title   = "Masons",
		players = {
			"Petus_mason", "Swed_mason", "Dormi_mason", "JikiSo_mason", "Alek_mason", "Zhekil_mason",
		},
	},
	vassals = {
		title   = "Vassals",
		players = { "Pilsner_vassal", "PePe_vassal", "JVD_vassal", "Semi_vassal" },
	},
	hansa = {
		title   = "Hansa",
		players = { "Qundark", "Kema" },
	},
	international = {
		title = "International",
		players = { "Alges", "Shishka_Intern", "Dasada", "Sakamoto", "Stesrr" },
	},
}]]

--- @param name string
--- @return clans.Clan
local function get_clan_from_storage(name)
	local data = clan_storage:get_string(name)
	return minetest.parse_json(data)
end

--- @param clan_name string
--- @param clan clans.Clan
local function set_clan_in_storage(clan_name, clan)
	local data = minetest.write_json(clan)
	clan_storage:set_string(clan_name, data)
end

--- @return table
local function list_clans_from_storage()
	return clan_storage:get_keys()
end

--- @type table<string,boolean> local cache for clan is online
local clan_is_online_cache = {}

--- @param player_name string
--- @return clans.Clan|nil returns clan data ( `{ title = "...", players {...}, ... }` )
local function get_clan_by_player_name(player_name)
	for _, clan_name in ipairs(list_clans_from_storage()) do
		local clan = get_clan_from_storage(clan_name)
		if clan.players == nil then return nil end
		if table.contains(clan.players, player_name) then
			return clan
		end
	end

	return nil
end

--- @param player Player
--- @return clans.Clan|nil returns clan data ( `{ title = "...", players {...}, ... }` )
local function get_clan_by_player(player)
	local player_name = player:get_player_name()
	return get_clan_by_player_name(player_name)
end

--- @param name string
--- @return boolean|nil
local function check_clan_is_online(name)
	local clan = get_clan_from_storage(name)
	if not clan then return nil end
	for _, player in pairs(minetest.get_connected_players()) do
		if table.contains(clan.players, player:get_player_name()) then
			return true
		end
	end
	return false
end

--- @param name string
--- @return boolean|nil
local function clan_is_online(name)
	if not get_clan_from_storage(name) then return nil end
	if clan_is_online_cache[name] == nil then
		clan_is_online_cache[name] = check_clan_is_online(name)
	end

	return clan_is_online_cache[name]
end

minetest.register_on_joinplayer(function(player, last_login)
	if not player or not player:is_player() then
		return
	end

	local clan = get_clan_by_player_name(player)
	if not clan then
		return
	end

	clan_is_online_cache[clan.name] = true

	player:set_nametag_attributes({
		text = player:get_player_name() .. " " .. minetest.colorize("#3d7", "["..clan.title.."]"),
	})
end)

minetest.register_on_leaveplayer(function(player, timed_out)
	if not player or not player:is_player() then
		return
	end
	local clan = get_clan_by_player_name(player)
	if not clan then
		return
	end

	clan_is_online_cache[clan.name] = nil -- reset cache (this will force recalc cache)
end)

--- API ---

clans = {
	get_by_player  = get_clan_by_player,
	get_by_name    = get_clan_from_storage,
	clan_is_online = clan_is_online,
}

clans.err = {
	[1] = "clan with this name is already created",
	[2] = "given player(s) is(are) already assigned to some other clan",
	[3] = "there is no clan with given name",
	[4] = "there is no such player in this clan",
}

--- @param name string
--- @param members table<string>
--- @return table
function clans.create_clan(name, title, members)
	if clans.get_by_name(name) ~= nil then return { false, clans.err[1] } end

	for _, m in ipairs(members) do
		if get_clan_by_player_name(m) ~= nil then return { false, clans.err[2] } end
	end

	set_clan_in_storage(name, { title = title, players = members })
	return { true, nil }
end

--- @param name string
--- @return table
function clans.remove_clan(name)
	if clans.get_by_name(name) == nil then return { false, clans.err[3] } end

	set_clan_in_storage(name, nil)
	if clan_is_online_cache[name] ~= nil then clan_is_online_cache[name] = nil end
	return { true, nil }
end

--- @param clan_name string
--- @param player string
--- @return table
function clans.add_player_to_clan(clan_name, player)
	if clans.get_by_name(clan_name) == nil then return { false, clans.err[3] } end
	if get_clan_by_player_name(player) ~= nil then return { false, clans.err[2] } end

	local clan = get_clan_from_storage(clan_name)
	table.insert(clan.players, player)
	set_clan_in_storage(clan_name, clan)
	return { true, nil }
end

--- @param clan_name string
--- @param player string
--- @return table
function clans.remove_player_from_clan(clan_name, player)
	if clans.get_by_name(clan_name) == nil then return { false, clans.err[3] } end
	if get_clan_by_player_name(player) == nil then return { false, clans.err[4] } end

	local clan = get_clan_from_storage(clan_name)
	local updated_members = {}
	for _, p in ipairs(clan.players) do
		if p ~= player then table.insert(updated_members, p) end
	end
	clan.players = updated_members
	set_clan_in_storage(clan_name, clan)

	return { true, nil }
end

--- @return table
function clans.list_clans()
	return list_clans_from_storage()
end

--- @param name string
--- @return table
function clans.get_clan(name)
	if clans.get_by_name(name) == nil then return { false, clans.err[3] } end

	return get_clan_from_storage(name)
end

