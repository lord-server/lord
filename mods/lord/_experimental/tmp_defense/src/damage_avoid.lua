local math_random
	= math.random


--- @param player Player
--- @return number
local function get_damage_avoid_chance(player)
	-- TODO: don't recalc each time. Use `defense.for_player(player).damage_avoid_chance`.
	local damage_avoid_chance = 0
	for _, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() > 0 then
			damage_avoid_chance = damage_avoid_chance + (stack:get_definition().groups["damage_avoid_chance"] or 0)
		end
	end

	return damage_avoid_chance
end

--- @param player Player
--- @param
local handle_armor_damage_avoid = function(player)
	local name = player:get_player_name()
	if not name then return end

	local armor_damage_avoid_chance = get_damage_avoid_chance(player)
	if math_random(100) < armor_damage_avoid_chance then
		return true -- this will prevent the default damage mechanism, so no damage will be applied
	end
end

minetest.register_on_punchplayer(handle_armor_damage_avoid)
