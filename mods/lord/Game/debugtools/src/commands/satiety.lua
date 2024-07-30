

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
