--- @class clans.Clan
--- @field public name string
--- @field public title string
--- @field public players table<number,string>


-- HACK: this is a quick hardcoded local storage for clans data
-- TODO: save this data somewhere else (mod-storage?)
-- TODO: commands for manage
--- @type table<string,clans.Clan>
local clans_storage = {
	masons = {
		name    = "masons",
		title   = "Masons",
		players = {	"Petus_mason", "Swed_mason", "Dormi_mason", "JikiSo_mason", "Alek_mason", "Zhekil_mason" },
	},
	--havit = {
	--	name    = "havit",
	--	title   = "Havit-Nakyar",
	--	players = { "Doloment", "Sdoh", "Aiex" }
	--},
	vassals = {
		name    = "vassals",
		title   = "Vassals",
		players = { "Pilsner_vassal", "PePe_vassal", "JVD_vassal", "Semi_vassal" },
	},
}
--- @type table<string,boolean> local cache for clan is online
local clan_is_online_cache = {}

--- @param player Player
--- @return clans.Clan|nil returns clan data ( `{ title = "...", players {...}, ... }` )
local function get_clan_by_player(player)
	local player_name = player:get_player_name()

	for _, clan in pairs(clans_storage) do
		if table.contains(clan.players, player_name) then
			return clan
		end
	end

	return nil
end

--- @param name string
local function get_clan_by_name(name)
	return clans_storage[name]
end

--- @param name string
--- @return boolean|nil
local function check_clan_is_online(name)
	local clan = get_clan_by_name(name)
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
	if not clans_storage[name] then return nil end
	if clan_is_online_cache[name] == nil then
		clan_is_online_cache[name] = check_clan_is_online(name)
	end

	return clan_is_online_cache[name]
end

minetest.register_on_joinplayer(function(player, last_login)
	if not player or not player:is_player() then
		return
	end

	local clan = get_clan_by_player(player)
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
	local clan = get_clan_by_player(player)
	if not clan then
		return
	end

	clan_is_online_cache[clan.name] = check_clan_is_online(clan.name)
end)

--- API ---

clans = {
	get_by_player  = get_clan_by_player,
	get_by_name    = get_clan_by_name,
	clan_is_online = clan_is_online,
}
