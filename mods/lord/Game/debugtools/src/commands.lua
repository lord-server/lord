
------------------------   S A T I E T Y   ------------------------
minetest.register_chatcommand("satiety.get", {
	func = function(name, _)
		local player    = minetest.get_player_by_name(name)
		local inventory = player:get_inventory()

		return
			true,
			"From inventory: " .. inventory:get_stack("hunger", 1):get_count() .. "\n" ..
			"From `hbhunger.get_hunger_raw()`: " .. hbhunger.get_hunger_raw(player) .. "\n" ..
			"From `hbhunger.hunger[name]`: " .. hbhunger.hunger[name]
	end
})

minetest.register_chatcommand("satiety.set", {
	params = "<value>",
	func   = function(name, param)
		if not param or param == "" then
			return false, "<value> not specified"
		end
		if not tonumber(param) then
			return false, "<value> must be a positive number"
		end

		local player    = minetest.get_player_by_name(name)
		local inventory = player:get_inventory()

		hbhunger.hunger[name] = tonumber(param)
		hbhunger.set_hunger_raw(player)

		return
			true,
			"From inventory: " .. inventory:get_stack("hunger", 1):get_count() .. "\n" ..
			"From `hbhunger.get_hunger_raw()`: " .. hbhunger.get_hunger_raw(player) .. "\n" ..
			"From `hbhunger.hunger[name]`: " .. hbhunger.hunger[name]
	end
})

------------------------   A R M O R   ------------------------
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
