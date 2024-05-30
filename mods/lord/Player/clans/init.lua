local mod_path    = minetest.get_modpath(minetest.get_current_modname())
local old_require = require
require           = function(name) return dofile(mod_path .. "/src/" .. name:gsub("%.", "/") .. ".lua") end

clans = {} -- namespace

local clan_storage = require("storage")

--- @param player_name string
--- @return clans.Clan|nil
function clans.get_by_player_name(player_name)
	for _, clan in pairs(clan_storage.list()) do
		if table.contains(clan.players, player_name) then
			return clan
		end
	end
	return nil
end

--- @param player Player
--- @return clans.Clan|nil
function clans.get_by_player(player)
	local player_name = player:get_player_name()
	return clans.get_by_player_name(player_name)
end

--- @param name string
--- @return clans.Clan|nil
function clans.get_by_name(name)
	return clan_storage.get(name)
end

clans.err = {
	[1] = "clan with this name is already created",
	[2] = "given player(s) is(are) already assigned to some other clan",
	[3] = "there is no clan with given name",
	[4] = "there is no such player in this clan",
	[5] = "max players reached!",
	[6] = "clan with this name is blocked",
}

---@type integer readonly
clans.max_players_in_clan = tonumber(minetest.settings:get("clans.max_players_in_clan")) or 10

--- @param name string
--- @param title string
--- @param members string[]
--- @return boolean,string|nil
function clans.create_clan(name, title, members)
	if clans.get_by_name(name) ~= nil then return false, clans.err[1] end
	if #members > clans.max_players_in_clan then return false, clans.err[5] end
	for _, m in ipairs(members) do
		if clans.get_by_player_name(m) ~= nil then return false, clans.err[2] end
	end

	clan_storage.set({ name = name, title = title, players = members or {} })
	return true, nil
end

--- @param name string
--- @return boolean,string|nil
function clans.remove_clan(name)
	if clans.get_by_name(name) == nil then return false, clans.err[3] end

	clan_storage.delete(name)
	return true, nil
end

--- @param clan_name string
--- @param player_name string
--- @return boolean,string|nil
function clans.add_player_to_clan(clan_name, player_name)
	if clans.get_by_player_name(player_name) ~= nil then return false, clans.err[2] end
	local clan = clans.get_by_name(clan_name)
	if clan == nil then return false, clans.err[3] end
	if clan.is_blocked then return false, clans.err[6] end
	if #clan.players+1 > clans.max_players_in_clan then return false, clans.err[5] end

	table.insert(clan.players, player_name)
	clan_storage.set(clan)
	return true, nil
end

--- @param clan_name string
--- @param player_name string
--- @return boolean,string|nil
function clans.remove_player_from_clan(clan_name, player_name)
	local clan = clans.get_by_name(clan_name)
	if clan == nil then return false, clans.err[3] end

	if clans.get_by_player_name(player_name) == nil or clans.get_by_player_name(player_name).name ~= clan_name then
		return false, clans.err[4]
	end

	local updated_members = {}
	for _, p in ipairs(clan.players) do
		if p ~= player_name then table.insert(updated_members, p) end
	end
	clan.players = updated_members
	clan_storage.set(clan)

	return true, nil
end

--- @return table<string,clans.Clan>
function clans.list()
	return clan_storage.list()
end

---@param name string @clan name (ID)
---@return boolean|nil @boolean if clan exists or nil else
function clans.is_blocked(name)
	local clan = clans.get_by_name(name)
	if not clan then return nil end
	if not clan.is_blocked then
		return false
	end
	return true
end

---@param name string @clan name (ID)
---@return boolean|nil @is clan blocked now, `nil` if clan does not exist
function clans.toggle_block(name)
	local clan = clans.get_by_name(name)
	if not clan then return nil end
	local old_is_blocked = clan.is_blocked
	if old_is_blocked then
		clan.is_blocked = nil
	else
		clan.is_blocked = true
	end
	clan_storage.set(clan)
	return not old_is_blocked
end

--- @param name string
--- @return boolean|nil
local function check_clan_is_online(name)
	local clan = clans.get_by_name(name)
	if not clan then return nil end
	for _, player in pairs(minetest.get_connected_players()) do
		if table.contains(clan.players, player:get_player_name()) then
			return true
		end
	end
	return false
end

--- @type table<string,boolean> local cache for clan is online
local clan_is_online_cache = {}

--- @param name string
--- @return boolean|nil
function clans.clan_is_online(name)
	local clan = clans.get_by_name(name)
	if not clan then return nil end
	if clan.is_blocked then return nil end -- clan is offline if it is blocked

	if clan_is_online_cache[name] == nil then
		clan_is_online_cache[name] = check_clan_is_online(name)
	end

	return clan_is_online_cache[name]
end

minetest.register_on_joinplayer(function(player, _)
	if not player or not player:is_player() then return end

	--- @type Player
	player = player -- HACK: makes VSCode type hints work

	local clan = clans.get_by_player(player)

	if not clan then return end

	clan_is_online_cache[clan.name] = true
	player:set_nametag_attributes({
		text = player:get_player_name() .. " " .. minetest.colorize("#3d7", "["..clan.title.."]"),
	})
end)

minetest.register_on_leaveplayer(function(player, _)
	if not player or not player:is_player() then return end

	--- @type Player
	player = player -- HACK: makes VSCode type hints work

	local clan = clans.get_by_player(player)
	if not clan then return end

	clan_is_online_cache[clan.name] = nil -- reset cache (this will force recalc cache)
end)


require("commands")
require("last_login_kick")

require = old_require
