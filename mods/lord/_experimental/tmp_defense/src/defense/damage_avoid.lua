local math_random
	= math.random


--- @param player Player
local handle_armor_damage_avoid = function(player)
	local name = player:get_player_name()
	if not name then return end

	local armor_damage_avoid_chance = defense.for_player(player).damage_avoid_chance
	if math_random(100) < armor_damage_avoid_chance then
		return true -- this will prevent the default damage mechanism, so no damage will be applied
	end
end

minetest.register_on_punchplayer(handle_armor_damage_avoid)
