local direct_behavior = function(player, amount, reason, source)
	amount = lord_damage.calculate_damage_absorption(player, amount, "direct")
	reason = reason or { type = "set_hp", damage_type = "direct", source = source, }
	return player:set_hp(player:get_hp() - amount, reason)
end

local direct_periodic_behavior = function(player, amount, reason, source, chunks)
	amount = lord_damage.calculate_damage_absorption(player, amount, "direct_periodic")
	reason = reason or { type = "set_hp", damage_type = "direct_periodic", source = source, }

	local max_cycle       = math.floor(amount/chunks)
	local leftover_damage = amount%chunks

	local cycle_number = 0
	for i = 1, max_cycle do
		minetest.after(cycle_number, function()
			if not lord_damage.get_source_status(player, source) then
				leftover_damage = 0
				return
			end

			player:set_hp(player:get_hp() - chunks, reason)
		end)
		cycle_number = cycle_number + 1
	end
	if leftover_damage ~= 0 then
		player:set_hp(player:get_hp() - chunks, reason)
	end
end


local physical_behavior = function(player, amount, reason, source)
	amount = lord_damage.calculate_damage_absorption(player, amount, "physical")
	reason = reason or { type = "set_hp", damage_type = "physical", source = source, }
	return player:set_hp(player:get_hp() - amount, reason)
end

local physical_periodic_behavior = function(player, amount, reason, source, chunks)
	amount = lord_damage.calculate_damage_absorption(player, amount, "physical_periodic")
	reason = reason or { type = "set_hp", damage_type = "physical_periodic", source = source, }

	local max_cycle       = math.floor(amount/chunks)
	local leftover_damage = amount%chunks

	local cycle_number = 0
	for i = 1, max_cycle do
		minetest.after(cycle_number, function()
			if not lord_damage.get_source_status(player, source) then
				leftover_damage = 0
				return
			end

			player:set_hp(player:get_hp() - chunks, reason)
		end)
		cycle_number = cycle_number + 1
	end
	if leftover_damage ~= 0 then
		player:set_hp(player:get_hp() - chunks, reason)
	end
end

local toxic_periodic_behavior = function(player, amount, reason, source, chunks)
	amount = lord_damage.calculate_damage_absorption(player, amount, "toxic_periodic")
	reason = reason or { type = "set_hp", damage_type = "toxic_periodic", source = source, }

	local max_cycle       = math.floor(amount/chunks)
	local leftover_damage = amount%chunks

	local cycle_number = 0
	for i = 1, max_cycle do
		minetest.after(cycle_number, function()
			if not lord_damage.get_source_status(player, source) then
				leftover_damage = 0
				return
			end

			player:set_hp(player:get_hp() - chunks, reason)
		end)
		cycle_number = cycle_number + 1
	end
	if leftover_damage ~= 0 then
		player:set_hp(player:get_hp() - chunks, reason)
	end
end

local fiery_periodic_behavior = function(player, amount, reason, source, chunks)
	amount = lord_damage.calculate_damage_absorption(player, amount, "fiery_periodic")
	reason = reason or { type = "set_hp", damage_type = "fiery_periodic", source = source, }

	local max_cycle       = math.floor(amount/chunks)
	local leftover_damage = amount%chunks

	local cycle_number = 0
	for i = 1, max_cycle do
		minetest.after(cycle_number, function()
			if not lord_damage.get_source_status(player, source) then
				leftover_damage = 0
				return
			end

			player:set_hp(player:get_hp() - chunks, reason)
		end)
		cycle_number = cycle_number + 1
	end
	if leftover_damage ~= 0 then
		player:set_hp(player:get_hp() - chunks, reason)
	end
end

return {
	["direct"]            = direct_behavior,
	["direct_periodic"]   = direct_periodic_behavior,
	["physical"]          = physical_behavior,
	["physical_periodic"] = physical_periodic_behavior,
	["toxic_periodic"]    = toxic_periodic_behavior,
	["fiery_periodic"]    = fiery_periodic_behavior,
}
