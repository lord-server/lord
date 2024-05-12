-- Methods to work with clans mod storage
-- Mod storage store keys and their values (see StorageRef). Key is clan id, its value is json-serialized clan data
-- without clan name (see clans.Clan class).
-- StorageRef:
-- string               JSON-serialized clans.Clan class but without name field
-- "clan internal id" = [ title: "clan title", players: [ "a player 1", "a player 2" ] ]

local clan_storage = {} -- namespace for storage manipulations

--- @class clans.Clan
--- @field public name string
--- @field public title string
--- @field public players table<number,string>

local storage = minetest.get_mod_storage()

--- @return table<string,clans.Clan>
local function storage2cache()
	local cache = {}
	local raw_data = storage:to_table().fields
	for clan_name, clan_json in pairs(raw_data) do
		cache[clan_name] = minetest.parse_json(clan_json)
		-- TODO: handle parse_json error with minetest.error
		print("storage2cache: " .. clan_name .. ": " .. clan_json .. __FILE_LINE__())
		cache[clan_name].name = clan_name
	end
	return cache
end
local cache = storage2cache()


--- @param name string
--- @return clans.Clan|nil
function clan_storage.get(name)
	-- Данной строки не должно быть при штатной работе программы по задумке
	-- if cache[name].players == nil then cache[name].players = {} end
	return cache[name]
end

--- @param clan clans.Clan
function clan_storage.set(clan)
	cache[clan.name] = clan
	local clan_name = clan.name
	local storage_clan = table.copy(clan)
	local data = minetest.write_json(storage_clan)
	storage:set_string(clan_name, data)
end

--- @return table<string,clans.Clan>
function clan_storage.list()
	print(__FUNC__() .. ": " .. dump(cache) .. __FILE_LINE__())
	return cache
end

--- @param name string
function clan_storage.delete(name)
	storage:set_string(name, "")
	cache[name] = nil
end

return clan_storage
