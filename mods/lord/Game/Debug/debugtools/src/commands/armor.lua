
minetest.register_chatcommand("armor.get", {
	func = function(name, _)
		return true, dump(minetest.get_player_by_name(name):get_armor_groups())
	end
})

minetest.register_chatcommand("armor.set", {
	params = "<type> [value]",
	func   = function(name, param)
		if not param or param == "" then
			return false, "params: <type> [<value>]"
		end
		local params = param:split(" ")
		if #params < 1 or #params > 2 then
			return false, "params: <type> [<value>]"
		end

		local type         = params[1]
		local value        = tonumber(params[2])

		local player       = minetest.get_player_by_name(name)
		local armor_groups = player:get_armor_groups()
		armor_groups[type] = value
		player:set_armor_groups(armor_groups)

		return true, dump(minetest.get_player_by_name(name):get_armor_groups())
	end,
})
