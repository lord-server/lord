

minetest.register_chatcommand("physics.get", {
	func = function(name, _)
		local player    = minetest.get_player_by_name(name)

		return
			true,
			"Physics overrides: " .. dump(player:get_physics_override())
	end
})

minetest.register_chatcommand("physics.set", {
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

		local player            = minetest.get_player_by_name(name)
		local physics_overrides = player:get_physics_override()
		physics_overrides[type] = value
		player:set_physics_override(physics_overrides)

		return true, dump(player:get_physics_override())
	end
})
