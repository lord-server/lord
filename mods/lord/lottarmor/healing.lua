local math_random
	= math.random


--- @param player Player
local function get_armor_healing_chance(player)
	local armor_healing_chance = 0
	for _, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() > 0 then
			armor_healing_chance = armor_healing_chance + (stack:get_definition().groups["armor_heal"] or 0)
		end
	end
end

local handle_armor_healing = function(player)
	local name = player:get_player_name()
	if not name then return end

	local armor_healing_chance = get_armor_healing_chance(player)
	if math_random(100) < armor_healing_chance then
		player:set_hp(armor.player_hp[name])
		return
	end
end

minetest.register_on_punchplayer(handle_armor_healing)
