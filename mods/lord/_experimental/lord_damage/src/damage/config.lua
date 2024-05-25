local physical_behavior = function(player, amount, reason)
	--TODO: make a separate behavior with some visual effects
	return lord_damage.base_behavior(player, amount, "physical", reason or { type = "set_hp", damage_type = "physical" })
end

local toxic_behavior = function(player, amount, reason)
	--TODO: turn the healthbar green
	local sum = 0
	amount = lord_damage.calculate_damage_absorption(player, amount, "toxic")
	for i = 1, amount do
		minetest.after(sum, function()
			--TODO: add cancel check
			player:set_hp(player:get_hp() - 1, reason or { type = "set_hp", damage_type = "toxic" })
		end)
		sum = sum + 1
	end
end

local fiery_behavior = function(player, amount, reason)
	--TODO: add fire to the player model and the player screen
	local sum = 0
	amount = lord_damage.calculate_damage_absorption(player, amount, "fiery")
	for i = 1, amount do
		minetest.after(sum, function()
			--TODO: add cancel check + be on fire after the damage source stopped hitting (except when extinguished)
			player:set_hp(player:get_hp() - 1, reason or { type = "set_hp", damage_type = "fiery" })
		end)
		sum = sum + 1
	end
end

return {
	["physical"] = physical_behavior,
	["toxic"] = toxic_behavior,
	["fiery"] = fiery_behavior,
}
