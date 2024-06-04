
--- @class web_integration.Storage
local Storage = {
	--- @private
	--- @static
	--- @type StorageRef
	mod_storage = minetest.get_mod_storage(),
}

--- @param player_name string
--- @return number|nil
function Storage.get_player_web_id(player_name)
	return tonumber(Storage.mod_storage:get("player:" .. player_name .. ":web_id"))
end

--- @param player_name string
--- @param web_id      number
function Storage.set_player_web_id(player_name, web_id)
	Storage.mod_storage:set_int("player:" .. player_name .. ":web_id", web_id)
end


return Storage
