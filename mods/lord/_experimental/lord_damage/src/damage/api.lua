local function calculate_damage_absorption(player, amount, damage_type)
	local protection = player:get_armor_groups()[damage_type]
	if not protection or type(protection) ~= "number" or protection <= 0 then
		return amount
	end

	return amount - protection
end

local damage = {
	--- @type table<string,function>
	damage_types = {},
}

local function set_source(object, source, value)
	if not value then
		source = nil
	end
	local properties = object:get_properties()
	table.insert(properties.active_sources, source)
	object:set_properties(properties)
end

local function get_source_status(object, source)
	local properties = object:get_properties()
	if properties.active_sources and table.contains(properties.active_sources, source) then
		return true
	end
end

--- @param damage_type string    damage type name
--- @param behavior    function  function which is called on deal_damage()
local function register_damage_type(damage_type, behavior)
	damage.damage_types[damage_type] = behavior
	return true
end

--- @return table<string, function>  a table containing all registered damage types
local function get_registered_damage_types()
	return damage.damage_types
end

local function deal_damage(player, amount, damage_type, reason, source, chunks)
	if not amount then
		return false
	end

	if not damage_type then
		damage_type = "direct"
	end

	chunks = chunks or 1

	local to_return = damage.damage_types[damage_type](player, amount, reason, source, chunks)
	return to_return
end

local function base_behavior(player, amount, damage_type, reason, source)
	amount = calculate_damage_absorption(player, amount, damage_type)
	reason = reason or { type = "set_hp", damage_type = damage_type, source = source, }
	-- THE FOLLOWING LINE IS FOR TESTING PURPOSES ONLY! REMOVE IT WHEN THE DAMAGE SYSTEM IS INTEGRATED INTO THE GAME.
	minetest.chat_send_player(source.dealer:get_player_name(), "Hit: "..amount.."!")
	return player:set_hp(player:get_hp() - amount, reason)
end

local function periodic_base_behavior(player, amount, damage_type, reason, source, chunks, do_in_cycle)
	amount = calculate_damage_absorption(player, amount, damage_type)
	reason = reason or { type = "set_hp", damage_type = damage_type, source = source, }
	do_in_cycle = do_in_cycle or function() end
	local caused_by_source = false
	if source then
		caused_by_source = true
	end


	local max_cycle       = math.floor(amount/chunks)
	local leftover_damage = amount%chunks
	local player_has_died = false
	local player_has_left = false

	local cycle_number = 0
	for i = 1, max_cycle do
		minetest.after(cycle_number, function()
			minetest.chat_send_all("Pass")
			if not player then
				return
			end

			if player:is_player() then
				minetest.chat_send_all("Is player")
				minetest.register_on_dieplayer(function(dieplayer)
					if dieplayer:get_player_name() == player:get_player_name() then
						player_has_died = true
					end
				end)
				minetest.register_on_leaveplayer(function(leaveplayer)
					if leaveplayer:get_player_name() == player:get_player_name() then
						player_has_left = true
					end
				end)
			end

			local source_removed = false

			if caused_by_source then
				source_removed = (source and not get_source_status(player, source))
			end


			local reset_damage = player_has_died or player_has_left or source_removed
			if reset_damage then
				minetest.chat_send_all("Reset")
				leftover_damage = 0
				return
			end

			do_in_cycle()

			-- THE FOLLOWING LINE IS FOR TESTING PURPOSES ONLY! REMOVE IT WHEN THE DAMAGE SYSTEM IS INTEGRATED INTO THE GAME.
			minetest.chat_send_player(source.dealer:get_player_name(), "Hit: "..chunks.."!")
			player:set_hp(player:get_hp() - chunks, reason)
		end)
		cycle_number = cycle_number + 1
	end
	minetest.after(max_cycle, function()
		if not player or leftover_damage == 0 then
			return
		end

		if player:is_player() then
			minetest.register_on_dieplayer(function(dieplayer)
				if dieplayer:get_player_name() == player:get_player_name() then
					player_has_died = true
				end
			end)
			minetest.register_on_leaveplayer(function(leaveplayer)
				if leaveplayer:get_player_name() == player:get_player_name() then
					player_has_left = true
				end
			end)
		end

		local reset_damage = player_has_died or player_has_left or (source and not get_source_status(player, source))
		if reset_damage then
			return
		end

		do_in_cycle()

		-- THE FOLLOWING LINE IS FOR TESTING PURPOSES ONLY! REMOVE IT WHEN THE DAMAGE SYSTEM IS INTEGRATED INTO THE GAME.
		minetest.chat_send_player(source.dealer:get_player_name(), "Hit: "..leftover_damage.."!")
		player:set_hp(player:get_hp() - leftover_damage, reason)
	end)
end


return {
	calculate_damage_absorption = calculate_damage_absorption,
	register_damage_type        = register_damage_type,
	get_registered_damage_types = get_registered_damage_types,
	get_source_status           = get_source_status,
	base_behavior               = base_behavior,
	periodic_base_behavior      = periodic_base_behavior,
	deal_damage                 = deal_damage,
	set_source                  = set_source,
	get_nodes                   = function() return damage.damage_types end,
}
